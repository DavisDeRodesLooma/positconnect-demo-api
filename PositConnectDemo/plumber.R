#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)
library(pins)

#* @apiTitle Posit Connect Demo!
#* @apiDescription This is for our Posit Connect Hangout

#* Get Davis' Durham, NC Pizza Rankings
#* 
#* @get /pizza_rankings
function() {
    list(pizza_rankings = data.frame(
      restaurant = c("Hutchin's Garage",
                     "Pie Pushers",
                     "Pizzeria Del Torro",
                     "Ponpierri Pizza",
                     "Domino's"),
      ranking = c(seq(1, 5))
      
      
    ))
}

#* Submit Response to the Poll Question
#* 
#* @param submission_name Name for the submission
#* @param submission_state State code (2 letters or NA)
#* @param submission_country Country Code (2 letters)
#* 
#* @post /poll_submission
function(submission_name, submission_state, submission_country) {
  
  if(FALSE %in% ("character" == vapply(c(submission_name, submission_state, submission_country), class, ''))){

    return('Format as characters please')
    
  }else{
    
    if(FALSE %in% (2 == vapply(c(submission_state, submission_country), nchar, 1))){
      
      return('2 Character strings please.')
      
    }
    
    submit_df <- data.frame(submission_name = submission_name, 
                            submission_state = submission_state,
                            submission_country = submission_country)
    
    #You'll first need to initialize this pin
    #pins::pin(data.frame(), 'submission_df')
    
    old_pin_df <- pins::pin_get('submission_df')
    
    pins::pin(rbind(old_pin_df, submit_df), 'submission_df')
    
    
    return('Thanks for your submission!')
    
  }

  
    
    

}

