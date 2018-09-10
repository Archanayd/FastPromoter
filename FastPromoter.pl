
#>Chr1 CHROMOSOME dumped from ADB: Feb/3/09 16:9; last updated: 2007-12-20
open(IN1,"Athaliana_167_TAIR9.fa");


while ($line1 = <IN1>) #Fasta file
{
$id="";$seq1="";
      # $line1 =~ s/\s+|\t//; #remove white space  
      if($line1 =~ />(Chr\d)\s.*/) #arabidopsis
           {
            $hash{"$id1"} = $fasta;
           $id1 = "$1";
           #print $id1;
           #print OP3"$id1\n";
           $fasta="";

}
        else{ chomp $line1;      
              $fasta .= $line1;}
        
       
}
$hash{"$id1"} = $fasta;	
	
		#print OP3"@loc";


#Chr1    phytozomev10    gene    3631    5899    .       +       .       ID=AT1G01010.TAIR10;Name=AT1G01010

open(IN2, "Athaliana_kix.gff"); # Input GFF file
open(FILEW, ">result2.txt");
foreach $line2(<IN2>){
$id2="";$seq1="";$chr="";
#print $line2;
#$line2=~ s/\s+/\t/g;
chomp$line2;
$upstream_pos=0;

@char=split('\s+',$line2);

$chr=$char[0];
$start=$char[3];
$end=$char[4];
$strand=$char[6];

$id2= (split('Name=', $char[8]))[1];
chomp $id3;
#print $strand;
#print $id1;

#if strand is positive then use gene start position to get upstream and downstream coordinates
if($strand =~ /\+/){
$upstream_pos=$start-1500;
$downstream_pos= $start+200;


          
          if(exists ($hash{$chr})){ #print $chr;
          		$data=$hash{$chr};
            	print "$chr\t$upstream_pos\t$downstream_pos\n";
     			$len= $downstream_pos-$upstream_pos;
         
           $seq1=substr($data,$upstream_pos-1,$len+1);}
           
print FILEW">$id2|$upstream_pos-$downstream_pos|$chr|(strand=$strand)\n";
print FILEW"$seq1\n";
           }
 #if strand is positive then use gene end position to get upstream and downstream coordinates          
if($strand =~ /\-/){
$upstream_pos=$end+1500;
$downstream_pos= $end-200;


          
          if(exists ($hash{$chr})){ #print $chr;
           		$data=$hash{$chr};
           		print "$chr\t$downstream_pos\t$upstream_pos\n";
   				$len=$upstream_pos - $downstream_pos;
         
           $seq1=substr($data,$downstream_pos-1,$len+1);
        
$seq1 =~ tr /atcgATCG/tagcTAGC/; $seq1 = reverse($seq1);
}

print FILEW">$id2|$downstream_pos-$upstream_pos|$chr|(strand=$strand)\n";
print FILEW"$seq1\n";
}

#print FILEW">$id2|$upstream_pos-$downstream_pos|$chr|(strand=$strand)\n";
#print FILEW"$seq1\n";
}
$id2="";$seq1="";


