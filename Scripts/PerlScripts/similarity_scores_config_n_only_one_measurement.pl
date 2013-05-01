#! /usr/bin/perl -w 

use strict;
use warnings;

# Sample Perl program, showing how to use the
# WordNet::Similarity measures.

# WordNet::QueryData is required by all the
# relatedness modules.
use WordNet::QueryData;
use Getopt::Std;

# 'use' each module that you wish to use.

# my $opt_o = getopt('o');

use WordNet::Similarity::random;

use WordNet::Similarity::path;
use WordNet::Similarity::wup;
use WordNet::Similarity::lch;

use WordNet::Similarity::jcn;
use WordNet::Similarity::res;
use WordNet::Similarity::lin;

use WordNet::Similarity::hso;
use WordNet::Similarity::lesk;

use WordNet::Similarity::vector; 
use WordNet::Similarity::vector_pairs; 

# Get the concepts.
my $infile = shift;
#output file
my $outfile = shift;
#measurement_sought
my $measure = shift;


my $module = "WordNet::Similarity::$measure";

unless (defined $infile and defined $outfile) {
    print STDERR "Undefined input\n";
    print STDERR "Usage: similarity_scores_config_n_only_one_measurement.pl inputfile outputfile measurement\n";
    exit 1;
}


# Load WordNet::QueryData
print STDERR "Loading WordNet... ";
my $wn = WordNet::QueryData->new;
die "Unable to create WordNet object.\n" if(!$wn);
print STDERR "done.\n";

my $config = "config-files/config-$measure.conf";
print $config, "\n";

print STDERR "Creating ", $measure ," object... ";
my $simmeas = $module->new($wn, $config);
die "Unable to create jcn object.\n" if(!defined $simmeas);
my ($error, $errString) = $simmeas->getError();
die $errString if($error > 1);
print STDERR "done.\n";



open(INPUT, $infile);
my @pairs = <INPUT>;
close(INPUT);

open(OUT, ">$outfile");
print OUT "$measure \n";

foreach my $pair (@pairs)
{
    my @words = split(' ', $pair);
    if ($#words != 1)
    {
	print STDERR "Problem with input file: too many or too few words on one line"
    }
    else
    {
        my $w1 = $words[0];
        my $w2 = $words[1];
        my @w1senses = &get_senses_for_word($wn->querySense($w1));
        my @w2senses = &get_senses_for_word($wn->querySense($w2));
        my $score = &get_highest_similarity_scores(\@w1senses,\@w2senses);
        print OUT $w1, ' ', $w2, ' ', $score, "\n";
        
       
	
    }
}



sub get_highest_similarity_scores
{
    my $score = 0.0;
    
    my ($w1senses, $w2senses) = @_;
    foreach my $s1 (@{$w1senses})
    {
        foreach my $s2 (@{$w2senses})
        {
            my $new_score = &get_similarity_scores($s1, $s2);
            if($new_score > $score)
            {
		$score = $new_score;
	    }
        }
    }
    $score;
}



sub get_similarity_scores
{
    my $sim_score;
    my $wps1 = $_[0];
    my $wps2 = $_[1];

    my $value = $simmeas->getRelatedness($wps1, $wps2);
    ($error, $errString) = $simmeas->getError();
    die $errString if($error > 1);
    $sim_score = $value;
    print "$measure ErrorString = $errString\n" if $error;
    
    $sim_score;
}


sub get_senses_for_word
{
    my @senses;
    #take only the first pos (noun)
    foreach my $wspos ($_[0])
    {
	push(@senses, $wn->querySense($wspos));
    }
	@senses;
}

