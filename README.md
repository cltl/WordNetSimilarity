WordNetSimilarity
=================

Programs and scripts that test performance of WordNet similarity measurements using different settings

#Prerequisites#

##For Pedersen (2010)##

WordNet 3.0

WordNet::Similarity-2.05

WordNet::QueryData-1.49

Text::Similarity-0.09

As of May 1st 2013, these are the latest versions. Perl modules can be downloaded using CPAN.
For Linux, consider installing WordNet using apt-get.

##For Patwardhan and Pedersen (2006)##

WordNet 2.1

WordNet::Similarity-1.02

WordNet::Similarity-1.39

Text::Similarity-0.02

##For Calculating Ranking Coefficients##

SciPy
Pycluster

##Having both settings next to each other on your computer##

The scripts to run the experiments use the option -I to point perl to older versions of the module.
If you plan to run a lot of experiments with different versions of WordNet::Similarity, you may want to consider installing:

http://search.cpan.org/~ingy/only-0.28/lib/only.pm

and adapt the scripts accordingly.

To use the current scripts:

1. Install latest Pedersen (2010) versions (using apt-get and cpan, or following instructions from the WordNet homepage for mac)
2. Download alternative versions of Patwardhan and Pedersen (2006) (do **not** install these on the same machine)

The scripts assume the files with the older versions are unpacked in your home directory.

3. Prepare versions from Patwardhan and Pedersen (2006) so that they may be used for the experiments:

Prepare WordNet-QueryData:

		In the directory of WordNet-QueryData-1.39, run:

		mkdir -p lib/WordNet
		cp QueryData.pm lib/WordNet/
		
		

#Preparing the experiments#

	The current bash scripts assume that the older versions of Text::Similarity, WordNet::QueryData and WordNet::Similarity are all unpacked in the home directory.
	If you unpacked them somewhere else, make sure to change the paths after all -I options in the following script so that they point to the right directories: 
	
	- calculateScores_MC_RG_WN2.1_WNSIM_1.02.sh

	NB: 	There have been reports that unzipping in the home folder may lead to slightly different paths.
		The current path in the script would be (e.g.) ~/WordNet-QueryData-1.39/lib/
		Though the actual path may be: ~/WordNet-QueryData-1.39/WordNet-QueryData-1.39/lib/  
	Please check the actual path and adapt the script if necessary.
	
#Running the experiments#

	./RunBothExperiments.sh

	and wait....it takes a while for the full experiments to run
	
	Please don't hesitate to contact me if you have any problems.