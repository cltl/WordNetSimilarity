WordNetSimilarity
=================

Programs and scripts that test performance of WordNet similarity measurements using different settings

#Prerequisites#

##For Pedersen (2010)##

WordNet 3.0

WordNet::Similarity-2.05

WordNet::QueryData-1.49

Text::Similarity-0.09

As of May 1st 2013, these are the latest version. Perl modules can be downloaded using CPAN.
For Linux, consider installing WordNet using apt-get.

##For Patwardhan and Pedersen (2006)##

WordNet 2.1

WordNet::Similarity-1.02

WordNet::Similarity-1.39

Text::Similarity-0.02

##For Calculating Ranking Coefficients##

SciPy


##Having both settings next to each other on your computer##

There is a perl module called ``only'' that allows you to install alternative versions of modules and specify which version should be used when calling use.
It may be more convenient to use this module and change the perl scripts accordingly, if you plan to play with these settings a lot.

I followed the steps below:

1. Install latest Pedersen (2010) versions (using apt-get and cpan, or following instructions from the WordNet homepage for mac)
2. Download alternative versions of Patwardhan and Pedersen (2006) (do **not** install these on the same machine)
3. Prepare versions from Patwardhan and Pedersen (2006) so that they may be used for the experiments:

	a. Prepare WordNet-QueryData:

		In the directory of WordNet-QueryData-1.39, run:

		mkdir -p lib/WordNet
		cp QueryData.pm lib/WordNet/
		
	For simply running Patwardhan and Pedersen (2006):
		
	b. Prepare default files for WordNet-Similarity (replace the MY-PATH with the appropriate paths):

		export PERL5LIB=$PERL5LIB:MY-PATH/Text-Similarity-0.02/lib:MY-PATH/WordNet-QueryData-1.39/lib:MY-PATH/WordNet-Similarity-1.02/lib

	c. From the directory of WordNet-Similarity-1.02, run (replace MY-PATH with the appropriate path):
	
		perl MakeFile.pl WNHOME=MY-PATH/WordNet-2.1

#Preparing the experiments#

	The current bash scripts assume that the older versions of Text::Similarity, WordNet::QueryData and WordNet::Similarity are all unpacked in the home directory.
	If you unpacked them somewhere else, make sure to change the paths after all -I options in the following script: 
	
	- calculateScores_MC_RG_WN2.1_WNSIM_1.02.sh

#Running the experiments#

	./RunFullWN3.0Exp.sh
	./RunFullWN2.1Exp.sh

	and wait....
	
	Please don't hesitate to contact me if you have any problems.