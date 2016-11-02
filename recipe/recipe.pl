#!/usr/bin/perl

use YAML::Tiny;
use Data::Dumper;

# global vars
$GIT="/usr/bin/git";

my $r=YAML::Tiny->read($ARGV[0]);
print Dumper($r);

# check if directory exists
print $r{'sources'}{'path'}."/".$r{'recipe'}{'name'}."\n";
if(-d $r{'sources'}{'path'}."/".$r{'recipe'}{'name'})
{
	# exists, only update
	print "Update\n";
	$FLAG_CHANGED=update_sources($r{'sources'}{'program'},$r{'sources'}{'url'},$r{'sources'}{'path'}."/".$r{'recipe'}{'name'})
}
else
{
	# does not exist, download sources
	print "Get\n";
	get_sources($r{'sources'}{'program'},$r{'sources'}{'url'},$r{'sources'}{'path'}."/".$r{'recipe'}{'name'});
	$FLAG_CHANGED=1;
}

# check if data has changed
if($FLAG_CHANGED)
{
	# Yes, build and install
	print "Build\n";
}

##############################################################################
# UPDATE

sub update_sources
{
	($program,$url,$path)=@_;

	if(!-d $path)
	{
		print "\'$path\' does not exists for update.\n";
		return(-1);
	}

	if($program eq "git")
	{
		$RET=update_git($url,$path);
	}
	elsif($program eq "svn" or $program eq "subversion")
	{
		$RET=update_svn($url,$path);
	}
	elsif($program eq "wget")
	{
		$RET=update_wget($url,$path);
	}

	if($RET<0)
	{
		print "Error: $RET\n";
	}
	else
	{
		print "Nothing to do...\n";
		exit(0);
	}

	return($RET);
}

sub update_git()
{
	($url,$path)=@_;

	chdir($path);
	if(exec_command("git pull","Already up-to-date.")>0)
	{
		return(0);
	}
	else
	{
		return(1);
	}
}

sub update_svn()
{
	($url,$path)=@_;

	print "NOT IMPLEMENTED YET!\n";
	return(-1);
}

sub update_wget()
{
	($url,$path)=@_;

	print "NOT IMPLEMENTED YET!\n";
	return(-1);
}

##############################################################################
# GET

sub get_sources
{
	($program,$url,$path)=@_;

	if(-d $path)
	{
		print "\'$path\' already exists for getting sources.\n";
		return(-1);
	}

	if($program eq "git")
	{
		$RET=get_git($url,$path);
	}
	elsif($program eq "svn" or $program eq "subversion")
	{
		$RET=get_svn($url,$path);
	}
	elsif($program eq "wget")
	{
		$RET=get_wget($url,$path);
	}

	if($RET<0)
	{
		print "Error: $RET\n";
	}

	return($RET);
}

sub get_git()
{
	($url,$path)=@_;

	chdir($path);
	if(exec_command("git clone ".$url,"Checking connectivity... done.")>0)
	{
		return(0);
	}
	else
	{
		return(1);
	}
}

sub get_svn()
{
	($url,$path)=@_;

	print "NOT IMPLEMENTED YET!\n";
	return(-1);
}

sub get_wget()
{
	($url,$path)=@_;

	print "NOT IMPLEMENTED YET!\n";
	return(-1);
}

##############################################################################
# BUILD

##############################################################################
# SUBs

sub exec_command
{
	($cmd,$str)=@_;
	my($found)=0;

	open(CMD,"$cmd|")||die("Cannot start \'$cmd\': ?!\n");
	while($l=<CMD>)
	{
		chop($l);
		if($l=~/$str/)
		{
			$found+=1;
		}
	}
	return($found);
}
