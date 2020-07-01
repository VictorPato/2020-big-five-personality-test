# 2020-big-five-personality-test

In this project, we work with the Big Five Personality Quiz Answers to find cultural differences in the answers of different countries. We'd also like to explore which of the questions are more difficult to approach, measured in the time necessary to provide an answer.
Using the Big Five Personality Test extracted from Kaggle: https://www.kaggle.com/tunguz/big-five-personality-test

# Overview

*State what is the main goal of the project. State what sorts of question(s) you want to answer or what sort of system you want to build. (Questions may be non-technical -- e.g., is there a global correlation between coffee consumption and research output -- so long as they require data analysis or other technical solutions.)*

# Data

The dataset is the Big Five Personality Test extracted from Kaggle: https://www.kaggle.com/tunguz/big-five-personality-test  
It consists of 1015341 entries. From the Codebook in the same page:
> This data was collected (2016-2018) through an interactive on-line personality test.  
> The personality test was constructed with the "Big-Five Factor Markers" from the IPIP. https://ipip.ori.org/newBigFive5broadKey.htm  
> Participants were informed that their responses would be recorded and used for research at the beginning of the test, and asked to confirm their consent at the end of the test.  
>  
> The following items were presented on one page and each was rated on a five point scale using radio buttons. The order on page was was EXT1, AGR1, CSN1, EST1, OPN1, EXT2, etc.  
> The scale was labeled 1=Disagree, 3=Neutral, 5=Agree  
Describe the raw dataset that you considered for your project. Where did it come from? Why was it chosen? What information does it contain? What format was it in? What size was it? How many lines/records? Provide links.

Some of the items are:

> **EXT1**	I am the life of the party.  
> **EXT2**	I don't talk a lot.  
> **EXT3**	I feel comfortable around people.  
> ...  
> **EXT10**	I am quiet around strangers.  
> **EST1**	I get stressed out easily.  
> **EST2**	I am relaxed most of the time.  
> ...  
> **OPN8**	I use difficult words.  
> **OPN9**	I spend time reflecting on things.  
> **OPN10**	I am full of ideas.  

And there's some metadata associated with each entrie:

> The time spent on each question is also recorded in milliseconds. These are the variables ending in _E. This was calculated by taking the time when the button for the question was clicked minus the time of the most recent other button click.  
>  
> **dateload**    The timestamp when the survey was started.  
> **screenw**     The width the of user's screen in pixels  
> **screenh**     The height of the user's screen in pixels  
> **introelapse** The time in seconds spent on the landing / intro page  
> **testelapse**  The time in seconds spent on the page with the survey questions  
> **endelapse**   The time in seconds spent on the finalization page (where the user was asked to indicate if they has answered accurately and their answers could be stored and used for research. Again: this dataset only includes users who answered "Yes" to this question, users were free to answer no and could still view their results either way)  
> **IPC**         The number of records from the user's IP address in the dataset. For max cleanliness, only use records where this value is 1. High values can be because of shared networks (e.g. entire universities) or multiple submissions  
> **country**     The country, determined by technical information (NOT ASKED AS A QUESTION)  
> **lat_appx_lots_of_err**    approximate latitude of user. determined by technical information, THIS IS NOT VERY ACCURATE. Read the article "How an internet mapping glitch turned a random Kansas farm into a digital hell" https://splinternews.com/how-an-internet-mapping-glitch-turned-a-random-kansas-f-1793856052 to learn about the perils of relying on this information  
> **long_appx_lots_of_err**   approximate longitude of user  

# Methods

*Detail the methods used during the project. Provide an overview of the techniques/technologies used, why you used them and how you used them. Refer to the source-code delivered with the project. Describe any problems you encountered.*

# Results

*Detail the results of the project. Different projects will have different types of results; e.g., run-times or result sizes, evaluation of the methods you're comparing, the interface of the system you've built, and/or some of the results of the data analysis you conducted.*

# Conclusion

*Summarise main lessons learnt. What was easy? What was difficult? What could have been done better or more efficiently?*

# Appendix

*You can use this for key code snippets that you don't want to clutter the main text.*

