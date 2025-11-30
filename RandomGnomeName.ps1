$Prefixes = @("Lill","Min","Sm")
$OneSyllableRoots = ("bib","bin","blink","bob","did","dink","dun","fib","gig","glib","ingle","ink","ken","kirk","link","lop","mini","nib","nip","nub","rap","riff","ren","ti","tink","tinkle","trib","tum","wig")
$MultipleSyllableRoots = @("chibi","diddy","dunlop","giggle","itchker","tummytum","wiggle")
$Roots = @()
$Roots += $OneSyllableRoots
$Roots += $MultipleSyllableRoots
$Suffixes = @("abble","ibble","ing","inker","it","ito","kin","let","lin","ling","lingur","o","ocky","shick")
$Vowels = @("a","e","i","o","u")

function Get-GnomeName {
    Param(
        [parameter(Mandatory=$False)]
        [bool]$Prefix,
        [parameter(Mandatory=$False)]
        [bool]$Suffix
    )
    
    if((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}elseif((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = "$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])"}else{$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}

    if($OneSyllableRoots -contains $Root){$Suffix = $true}

    if(($Prefix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 6) -eq 1)){$Prefix = $true;$NamePrefix = $Prefixes[(Get-Random -Minimum 0 -Maximum ($Prefixes.Count))]}else{$NamePrefix=''}
    if(($Suffix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 6) -gt 1)){$Suffix = $true;$NameSuffix = $Suffixes[(Get-Random -Minimum 0 -Maximum ($Suffixes.Count))]}else{$NameSuffix =''}

    if(($NameSuffix -like "ing") -and (($Root -notlike "*a") -or ($Root -notlike "*e") -or ($Root -notlike "*i") -or ($Root -notlike "*o") -or ($Root -notlike "*u") -or ($Root -notlike "*y"))){$Root = "$($Root)$($Root[-1])"}
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

    if(($Prefix -eq $true) -and (($Root -notlike "a*") -or ($Root -like "e*") -or ($Root -notlike "i*") -or ($Root -notlike "o*") -or ($Root -notlike "u*") -or ($Root -notlike "y*"))){$NamePrefix = "$($NamePrefix)$($Vowels[(Get-Random -Minimum 0 -Maximum ($Vowels.Count))])"}

    $Name = "$($NamePrefix)$($Root)$($NameSuffix)".ToLower()
    $Name = "$($Name.Substring(0,1).ToUpper())"+"$($Name.Substring(1))"

    $Name = $Name.replace('aa','a')
    $Name = $Name.replace('ee','-e')
    $Name = $Name.replace('ei','e-i')
    $Name = $Name.replace('ii','i')
    $Name = $Name.replace('oo','o')
    $Name = $Name.replace('uu','u')
    $Name = $Name.replace('yy','y')
    $Name = $Name.replace('kk','k')
    $Name = $Name.replace('lll','-ll')
    $Name = $Name.replace('fff','-ff')

    if(($Name -notlike "*a") -and ($Name -notlike "*e") -and ($Name -notlike "*i") -and ($Name -notlike "*o") -and ($Name -notlike "*u") -and ($Name -notlike "*y") -and ((Get-Random -Minimum 1 -Maximum 3) -eq 1)){$Name = "$($Name)s"}
    if(($Name -notlike "*a") -and ($Name -notlike "*e") -and ($Name -notlike "*i") -and ($Name -notlike "*o") -and ($Name -notlike "*u") -and ($Name -notlike "*y") -and ($Name -notlike "*s") -and ($Suffix -eq $false) -and ((Get-Random -Minimum 1 -Maximum 4) -eq 1)){$Name = "$($Name)y"}

    $Name

}
