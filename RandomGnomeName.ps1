$Prefixes = @("d","did","silly")
$OneSyllableRoots = ("bib","big","blink","bob","bumble","did","dink","dumble","fib","gig","glib","ingle","ink","ken","ker","kin","kirk","link","nab","nib","nip","nub","pib","rap","riff","tink","tinkle","tum","wig","wink")
$MultipleSyllableRoots = @("bibble","chibi","diddy","giggle","itchker","nimble","riffle","sugar","tom","trib","tummytum","wiggle")
$Roots = @()
$Roots += $OneSyllableRoots
$Roots += $MultipleSyllableRoots
$Suffixes = @("abble","bee","bob","bin","chub","ibble","iggle","in","ing","-inker","it","-itcher","ken","kin","let","lin","link","ling","lingur","ocky","nub","nubbin","shick","tom","wiggle")
$Vowels = @("a","i")

function Get-GnomeName {
    Param(
        [parameter(Mandatory=$False)]
        [bool]$Prefix,
        [parameter(Mandatory=$False)]
        [bool]$Suffix
    )
    
    if((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}elseif((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = "$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])"}else{$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}

    if(($OneSyllableRoots -contains $Root) -or ($MultipleSyllableRoots -contains $Root)){$Suffix = $true}

    if(($Prefix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 11) -eq 1)){$Prefix = $true;$NamePrefix = $Prefixes[(Get-Random -Minimum 0 -Maximum ($Prefixes.Count))]}else{$NamePrefix=''}
    if(($Suffix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 6) -gt 1)){$Suffix = $true;$NameSuffix = $Suffixes[(Get-Random -Minimum 0 -Maximum ($Suffixes.Count))]}else{$NameSuffix =''}

    if(($NameSuffix -like "ing") -and (($Root -notlike "*a") -and ($Root -notlike "*e") -and ($Root -notlike "*i") -and ($Root -notlike "*o") -and ($Root -notlike "*u") -and ($Root -notlike "*y"))){$Root = "$($Root)$($Root[-1])"}
    if((($NameSuffix -like "abble") -or ($NameSuffix -like "ibble")) -and (($Root -like "*a") -or ($Root -like "*e") -or ($Root -like "*i") -or ($Root -like "*o") -or ($Root -like "*u") -or ($Root -like "*y"))){$NameSuffix = "bble"}
    if((($NameSuffix -like "it")) -and (($Root -like "*a") -or ($Root -like "*e") -or ($Root -like "*i") -or ($Root -like "*o") -or ($Root -like "*u") -or ($Root -like "*y"))){$NameSuffix = "t"}
    if(($NameSuffix -like "ocky") -and (($Root -like "*a") -or ($Root -like "*e") -or ($Root -like "*i") -or ($Root -like "*o") -or ($Root -like "*u"))){$NameSuffix = "ck"}
    if(($NameSuffix -like "ito") -and (($Root -like "*a") -or ($Root -like "*e") -or ($Root -like "*i") -or ($Root -like "*o") -or ($Root -like "*u"))){$NameSuffix = "t"}elseif(($NameSuffix -like "ito") -and ($Root -like "*y")){$Root=$Root.Substring(0, $Root.Length - 1);$NameSuffix = "o"}
    if($NameSuffix -like "o"){
    
        if(($Root -like "*a") -or ($Root -like "*e") -or ($Root -like "*i") -or ($Root -like "*o") -or ($Root -like "*u") -or ($Root -like "*y")){
       
            $NameSuffix = "$($Root)"
            
        }else{
       
            $Root = "$($Root)$($Root[-1])"

        }

    }

    if(($Prefix -eq $true) -and (($Root -notlike "a*") -or ($Root -like "e*") -or ($Root -notlike "i*") -or ($Root -notlike "o*") -or ($Root -notlike "u*") -or ($Root -notlike "y*"))){$NamePrefix = "$($NamePrefix)$($Vowels[(Get-Random -Minimum 0 -Maximum ($Vowels.Count))])-"}

    $Name = "$($NamePrefix)$($Root)$($NameSuffix)".ToLower()

    $Name = $Name.replace('aa','a')
    $Name = $Name.replace('ai','i')
    $Name = $Name.replace('ee','-e')
    if($NameSuffix -like "bee"){$Name = "$($Name.substring(0,($Name.Length -2)))bee"}
    
    if($Name -like "*nubbins*"){
    
        $Name = $Name.replace('nubbin','xxx')
        $Name = $Name.replace('bb','b')
        $Name = $Name.replace('xxx','nubbin')

    }else{
    
        $Name = $Name.replace('bb','b')
    
    }

    $Name = $Name.replace('bt','b-t')
    $Name = $Name.replace('bitch','b-itch')
    $Name = $Name.replace('ei','e-i')
    $Name = $Name.replace('ii','i')
    $Name = $Name.replace('oo','o')
    $Name = $Name.replace('pb','p-b')
    $Name = $Name.replace('uu','u')
    $Name = $Name.replace('yy','y')
    $Name = $Name.replace('kk','k')
    $Name = $Name.replace('kn','k-n')
    $Name = $Name.replace('kp','k-p')
    $Name = $Name.replace('kg','k-g')
    $Name = $Name.replace('kw','k-w')
    $Name = $Name.replace('lll','-ll')
    $Name = $Name.replace('mn','m-n')
    $Name = $Name.replace('fff','-ff')
    $Name = $Name.replace('rr','r')
    $Name = $Name.replace('ww','w')
    $Name = $Name.replace('yi','y-i')

    if($Name -like "*itchker*"){$Name = $Name.replace('itchker','itcher')}

    if($Name -like "*kock*"){
    
        $Roll = ''
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Roll -eq 1){$Name = $Name.replace('kock','kobb')}elseif($Roll -eq 2){$Name = $Name.replace('kock','kod')}else{$Name = $Name.replace('kock','kogg')}
        
    }

    if($Name -like "*cock*"){
    
        $Roll = ''
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Roll -eq 1){$Name = $Name.replace('cock','cobb')}elseif($Roll -eq 2){$Name = $Name.replace('cock','cod')}else{$Name = $Name.replace('cock','cogg')}
        
    }

    $Name = $Name.replace('fag','')

    if(($Name -notlike "*a") -and ($Name -notlike "*e") -and ($Name -notlike "*i") -and ($Name -notlike "*o") -and ($Name -notlike "*u") -and ($Name -notlike "*y") -and ((Get-Random -Minimum 1 -Maximum 3) -eq 1)){$Name = "$($Name)s"}
    if(($Name -notlike "*a") -and ($Name -notlike "*e") -and ($Name -notlike "*i") -and ($Name -notlike "*o") -and ($Name -notlike "*u") -and ($Name -notlike "*y") -and ($Name -notlike "*s") -and ($Suffix -eq $false) -and ((Get-Random -Minimum 1 -Maximum 4) -eq 1)){$Name = "$($Name)y"}
    if(($Name -like "*ny") -and ($Name -notlike "*nny")){$Name = "$($Name.Substring(0,($Name.Length - 2)))nny"}

    if($Name -like "*able"){
    
        $Roll = ''
        $Roll = Get-Random -Minimum 1 -Maximum 3

        if($Roll -eq 1){$Name = "$($Name.Substring(0,($Name.Length - 4)))$($Name.Substring(($Name.Length - 5),1))able"}else{$Name = "$($Name.Substring(0,($Name.Length - 4)))abble"}
        
    }

    if($Name -like "*nubin*"){$Name = $Name.replace('nubin','nubbin')}

    if($Name -like "*bigit*"){$Name = $Name.replace('bigit','bibbit')}
    if($Name -like "*bible*"){$Name = $Name.replace('bible','bibble')}

    if($Name -like "*umy"){$Name = "$($Name.Substring(0,($Name.Length - 3)))ummy"}
    if($Name -like "*uby"){$Name = "$($Name.Substring(0,($Name.Length - 3)))ubby"}
    if($Name -like "*iby"){$Name = "$($Name.Substring(0,($Name.Length - 3)))ibby"}
    if($Name -like "*ibin"){$Name = "$($Name.Substring(0,($Name.Length - 4)))ibbin"}
    if($Name -like "*umin"){$Name = "$($Name.Substring(0,($Name.Length - 4)))ummin"}
    if($Name -like "*ible"){$Name = "$($Name.Substring(0,($Name.Length - 4)))ibble"}
    if($Name -like "*eble"){$Name = "$($Name.Substring(0,($Name.Length - 4)))ebble"}
    if($Name -like "*ilet"){$Name = "$($Name.Substring(0,($Name.Length - 4)))illet"}
    
    $Name = $Name.replace('aa','a')
    $Name = $Name.replace('fff','ff')
    $Name = $Name.replace('uu','u')
    $Name = $Name.replace('kk','k')
    $Name = $Name.replace('--','-')
    $Name = $Name.replace('nn','n-n')

    $Name = "$($Name.Substring(0,1).ToUpper())"+"$($Name.Substring(1))"

    $Name

}
