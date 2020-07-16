# 2020-big-five-personality-test

In this project, we work with the Big Five Personality Quiz Answers to find cultural differences in the answers from the entries of different countries.  
Using the Big Five Personality Test extracted from Kaggle: https://www.kaggle.com/tunguz/big-five-personality-test  
You can find more information about the categories, the questions, and scoring in the following link: https://openpsychometrics.org/printable/big-five-personality-test.pdf   

# Overview

The main goal of the project is to analyze the answers given to the BFPQ by the country of their responder. We are eager to find differences in the average of the scores that might provide insight on the personality of the citizens of certain countries or continents. There's also an interesting metric being recorded, which is the total time used to answer the test. This information could be used to find if certain countries are better at knowing themselves (or simply understanding the test and following instructions!).  
  
Additionaly, we'd like to caracterize Chile as a country, and observe how it stacks against other countries of the world.

# Data

The dataset is the Big Five Personality Test extracted from Kaggle: https://www.kaggle.com/tunguz/big-five-personality-test  
It consists of 1015341 entries. From the Codebook in the same page:
> This data was collected (2016-2018) through an interactive on-line personality test.  
> The personality test was constructed with the "Big-Five Factor Markers" from the IPIP. https://ipip.ori.org/newBigFive5broadKey.htm  
> Participants were informed that their responses would be recorded and used for research at the beginning of the test, and asked to confirm their consent at the end of the test.  
>  
> The following items were presented on one page and each was rated on a five point scale using radio buttons. The order on page was was EXT1, AGR1, CSN1, EST1, OPN1, EXT2, etc.  
> The scale was labeled 1=Disagree, 3=Neutral, 5=Agree  

The categories are:  
**Openness to Experience** - How open a person is to new ideas and experiences  
**Conscientiousness** - How goal-directed, persistent, and organized a person is  
**Extroversion** - How much a person is energized by the outside world  
**Agreeableness** - How much a person puts others' interests and needs ahead of their own  
**Neuroticism** - How sensitive a person is to stress and negative emotional triggers  
  
Some of the questions are:

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

And there's some metadata associated with each entry:

> The time spent on each question is also recorded in milliseconds. These are the variables ending in \_E. This was calculated by taking the time when the button for the question was clicked minus the time of the most recent other button click.  
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

As the proyect was developed, we discovered that the data had a ton of missing values and incorrect values (i.e. negative times) that threw out our results. In consequence, we had to a proper clean up before using the data.  

We would also like to note that the test consists of positive questions (i.e. agreeing with the question raises the category score) and negative questions

# Methods

First of all, data has to be cleaned up. Rows with missing values had to be removed as well as rows with values outside normal ranges. As this clean up job is relatively straightforward, and had to be run just a single time, a simple Python script proved enough to convert this data into what we would use onwards. This script can be found in *cleancsv.py*

This cleaned up data was loaded into the Hadoop Distributed File System (HDFS) running in the course's server. Once loaded, and as recommended in the original data set, only entries that came from different IPs were used, in order to filter potential repeated entries. Finally, and arbitrarily, we only used countries with over 1000 entries, which we think could be a sample big enough to represent a country.  

...we believe that even though we have 1000 entries or more for each country, this sample can be heavily biased. The test was 1. only taken in online format 2. voluntary and 3. only taken in English. This can generate a big bias, especially on countries that do not speak English as their first language (more on this later)...

From this point onward we use Apache Pig to query the data. This technology proved powerful and flexible enough to run all of the queries we wanted to do. This queries can be found in the *.pig* files.

Finally, the results were exported as *.csv* files, and loaded into Google Sheets to create some charts.

# Results
First, we take the average of each category for each country. The average of the averages. In here we can see that some categories naturally score higher than others.
![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Scores%20by%20Category.png "Average Scores by Category")

In each of the following graphics, we show were all countries are positioned against each other. First, as the average of all categories, then by each category. As we wanted to know how our country stacked against others, it is highlighted in red. For comparison, we also took the country with most answers, the USA, and highlighted it purple.

![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Total%20Score%20by%20Country.png "Average Total Score by Country")
![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Agreeableness%20Score%20by%20Country.png "Average Agreeableness Score by Country")
![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Conscientiousness%20Score%20by%20Country.png "Average Conscientiousness Score by Country")
![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Extroversion%20by%20Country.png "Average Extroversion by Country")
![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Neuroticism%20Score%20by%20Country.png "Average Neuroticism Score by Country")
![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Openness%20to%20Experience%20Score%20by%20Country.png "Average Openness to Experience Score by Country")

Finally, we take the average time to answer each question by country
![alt text](https://github.com/cc5212/2020-big-five-personality-test/blob/master/results/Average%20Time%20to%20Answer%20by%20Country.png
 "Average Time to Answer by Country")
 
# Conclusion

*Summarise main lessons learnt. What was easy? What was difficult? What could have been done better or more efficiently?*

# Appendix

*You can use this for key code snippets that you don't want to clutter the main text.*

