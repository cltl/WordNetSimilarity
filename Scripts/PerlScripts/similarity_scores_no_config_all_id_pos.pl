#! /usr/bin/perl -w 

use strict;
use warnings;

# Sample Perl program, showing how to use the
# WordNet::Similarity measures.

# WordNet::QueryData is required by all the
# relatedness modules.
use WordNet::QueryData;

# 'use' each module that you wish to use.

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
my $outfile = shift;


unless (defined $infile and defined $outfile) {
    print STDERR "Undefined input\n";
    print STDERR "Usage: similarity_scores_no_config.pl inputfile outputfile\n";
    exit 1;
}


# Load WordNet::QueryData
print STDERR "Loading WordNet... ";
my $wn = WordNet::QueryData->new;
die "Unable to create WordNet object.\n" if(!$wn);
print STDERR "done.\n";



print STDERR "Creating jcn object... ";
my $jcn = WordNet::Similarity::jcn->new($wn);
die "Unable to create jcn object.\n" if(!defined $jcn);
my ($error, $errString) = $jcn->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating res object... ";
my $res = WordNet::Similarity::res->new($wn);
die "Unable to create res object.\n" if(!defined $res);
($error, $errString) = $res->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating lin object... ";
my $lin = WordNet::Similarity::lin->new($wn);
die "Unable to create lin object.\n" if(!defined $lin);
($error, $errString) = $lin->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating wup object... ";
my $wup = WordNet::Similarity::wup->new($wn);
die "Unable to create wup object.\n" if(!defined $wup);
($error, $errString) = $wup->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating lch object... ";
my $lch = WordNet::Similarity::lch->new($wn);
die "Unable to create lch object.\n" if(!defined $lch);
($error, $errString) = $lch->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating hso object... ";
my $hso = WordNet::Similarity::hso->new($wn);
die "Unable to create hso object.\n" if(!defined $hso);
($error, $errString) = $hso->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating path object... ";
my $path = WordNet::Similarity::path->new($wn);
die "Unable to create path object.\n" if(!defined $path);
($error, $errString) = $path->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating random object... ";
my $random = WordNet::Similarity::random->new($wn);
die "Unable to create random object.\n" if(!defined $random);
($error, $errString) = $random->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating lesk object... ";
my $lesk = WordNet::Similarity::lesk->new($wn);
#my $lesk = WordNet::Similarity::lesk->new($wn);
die "Unable to create lesk object.\n" if(!defined $lesk);
($error, $errString) = $lesk->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating vector object... ";
my $vector = WordNet::Similarity::vector->new($wn);
die "Unable to create vector object.\n" if(!defined $vector);
($error, $errString) = $vector->getError();
die $errString if($error > 1);
print STDERR "done.\n";

print STDERR "Creating vector_pairs object... ";
my $vector_pairs = WordNet::Similarity::vector_pairs->new($wn);
die "Unable to create vector_pairs object.\n" if(!defined $vector_pairs);
($error, $errString) = $vector_pairs->getError();
die $errString if($error > 1);
print STDERR "done.\n";


open(INPUT, $infile);
my @pairs = <INPUT>;
close(INPUT);

open(OUT, ">$outfile");


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
        my @comp_scores = &get_highest_similarity_scores(\@w1senses,\@w2senses);
        print OUT $w1, ' ', $w2;
        
        #easy readable output:
        #print OUT ":\n";
        #print OUT "\tjcn:\t", $comp_scores[0], "\n";
        #print OUT "\tlesk:\t", $comp_scores[1], "\n";
        #print OUT "\tpath:\t", $comp_scores[2], "\n";
        #print OUT "\tlch:\t", $comp_scores[3], "\n";
        #print OUT "\tvector:\t", $comp_scores[4], "\n";
        #print OUT "\tlin:\t", $comp_scores[5], "\n";
        #print OUT "\tres:\t", $comp_scores[6], "\n";
        #print OUT "\trandom:\t", $comp_scores[7], "\n";
        #print OUT "\twup:\t", $comp_scores[8], "\n\n";
        
        ###one line output, measurements separated by spaces:
        
        foreach my $sc (@comp_scores)
        {
            print OUT " ", $sc;
        }
        print OUT "\n";
	
    }
}



sub get_highest_similarity_scores
{
    my @scores;
    
    my ($w1senses, $w2senses) = @_;
    foreach my $s1 (@{$w1senses})
    {
        my @syns_parts1 = split('#',$s1);
        
        foreach my $s2 (@{$w2senses})
        {
            my @syns_parts2 = split('#',$s2);
            if ($syns_parts1[1] eq $syns_parts2[1])
            {
                my @new_scores = &get_similarity_scores($s1, $s2);
                if ($#scores <= 0)
                {
                    @scores = @new_scores;
                }
                else
                {
                    for(my $i = 0; $i <= $#scores; ++$i)
                    {
                        if($new_scores[$i] > $scores[$i])
                        {
                            $scores[$i] = $new_scores[$i];
                        }
                    }
                }
            }
        }
    }
    @scores;
}



sub get_similarity_scores
{
    my @sim_scores;
    my $wps1 = $_[0];
    my $wps2 = $_[1];
    
    
    my @wps_p1 = split('#', $wps1);
    my $value;
    
    if ($wps_p1[1] ne "a")
    {
        $value = $jcn->getRelatedness($wps1, $wps2);
        ($error, $errString) = $jcn->getError();
        die $errString if($error > 1);
    }
    else
    {
        $value = 0;
    }
    push(@sim_scores, $value);
    print "JCN ErrorString = $errString\n" if $error;
    
    $value = $lesk->getRelatedness($wps1, $wps2);
    ($error, $errString) = $lesk->getError();
    die $errString if($error > 1);
    push(@sim_scores, $value);
    print "LESK ErrorString = $errString\n" if $error;

    if ($wps_p1[1] ne "a")
    {
        $value = $path->getRelatedness($wps1, $wps2);
        ($error, $errString) = $path->getError();
        die $errString if($error > 1);
    }
    else
    {
        $value = 0;
    }
    push(@sim_scores, $value);
    print "PATH ErrorString = $errString\n" if $error;

    
    if ($wps_p1[1] ne "a")
    {
        $value = $lch->getRelatedness($wps1, $wps2);
        ($error, $errString) = $lch->getError();
        die $errString if($error > 1);
    }
    else
    {
        $value = 0;
    }
    push(@sim_scores, $value);
    print "LCH ErrorString = $errString\n" if $error;

    $value = $vector->getRelatedness($wps1, $wps2);
    ($error, $errString) = $vector->getError();
    die $errString if($error > 1);
    push(@sim_scores, $value);
    print "VECTOR ErrorString = $errString\n" if $error;

    
    if ($wps_p1[1] ne "a")
    {
        $value = $lin->getRelatedness($wps1, $wps2);
        ($error, $errString) = $lin->getError();
        die $errString if($error > 1);
    }
    else
    {
        $value = 0;
    }
    push(@sim_scores, $value);
    print "LIN ErrorString = $errString\n" if $error;

    
    if ($wps_p1[1] ne "a")
    {
        $value = $res->getRelatedness($wps1, $wps2);
        ($error, $errString) = $res->getError();
        die $errString if($error > 1);
    }
    else
    {
        $value = 0;
    }
    push(@sim_scores, $value);
    print "RES ErrorString = $errString\n" if $error;

    $value = $random->getRelatedness($wps1, $wps2);
    ($error, $errString) = $random->getError();
    die $errString if($error > 1);
    push(@sim_scores, $value);
    print "RANDOM ErrorString = $errString\n" if $error;

    
    if ($wps_p1[1] ne "a")
    {
        $value = $wup->getRelatedness($wps1, $wps2);
        ($error, $errString) = $wup->getError();
        die $errString if($error > 1);
    }
    else
    {
        $value = 0;
    }
    push(@sim_scores, $value);
    print "WUP ErrorString = $errString\n" if $error;
    
    
    $value = $vector_pairs->getRelatedness($wps1, $wps2);
    ($error, $errString) = $vector_pairs->getError();
    die $errString if($error > 1);
    push(@sim_scores, $value);
    print "VECTOR PAIRS ErrorString = $errString\n" if $error;
    
    
    $value = $hso->getRelatedness($wps1, $wps2);
    ($error, $errString) = $hso->getError();
    die $errString if($error > 1);
    push(@sim_scores, $value);
    print "HSO ErrorString = $errString\n" if $error;

    @sim_scores;
}


sub get_senses_for_word
{
    my @senses;
    foreach my $wspos (@_)
    {
        push(@senses, $wn->querySense($wspos));
    }
	@senses;
}

