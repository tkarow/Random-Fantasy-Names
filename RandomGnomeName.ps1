$Prefixes = @("Lil","Lilli","Min","Mini","Sma")
$OneSyllableRoots = ("bib","bob","did","dink","fib","ingle","ken","kirk","lop","ren","ti","tink","tinkle")
$MultipleSyllableRoots = @("diddy","dunlop","chibi")
$Roots = @()
$Roots += $OneSyllableRoots
$Roots += $MultipleSyllableRoots
$Suffixes = @("abble","chen","ibble","ina","ino","ing","inker","ito","itshker","kin","let","lin","ling","lingur","o","ocky","shi","shik")

function Get-GnomeName {
    Param(
        [parameter(Mandatory=$False)]
        [bool]$Prefix,
        [parameter(Mandatory=$False)]
        [bool]$Suffix
    )
    
    if((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}else{if((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = "$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])"}}

    if($OneSyllableRoots -contains $Root){$Suffix = $true}

    if(($Prefix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 4) -eq 3)){$NamePrefix = $Prefixes[(Get-Random -Minimum 0 -Maximum ($Prefixes.Count))]}else{$NamePrefix=''}
    if(($Suffix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 3) -eq 2)){$NameSuffix = $Suffixes[(Get-Random -Minimum 0 -Maximum ($Suffixes.Count))]}else{$NameSuffix =''}

    if(($NameSuffix -like "ing") -and (($Root -notlike "*a") -or ($Root -notlike "*e") -or ($Root -notlike "*i") -or ($Root -notlike "*o") -or ($Root -notlike "*u") -or ($Root -notlike "*y"))){$Root = "$($Root)$($Root[-1])"}
    if((($NameSuffix -like "abble") -or ($NameSuffix -like "ibble")) -and (($Root -like "*a") -or ($Root -like "*e") -or ($Root -like "*i") -or ($Root -like "*o") -or ($Root -like "*u") -or ($Root -like "*y"))){$NameSuffix = "bble"}

    $Name = "$($NamePrefix)$($Root)$($NameSuffix)".ToLower()
    $Name = "$($Name.Substring(0,1).ToUpper())"+"$($Name.Substring(1))"

    $Name = $Name.replace('aa','a')
    $Name = $Name.replace('ee','e')
    $Name = $Name.replace('ii','i')
    $Name = $Name.replace('oo','o')
    $Name = $Name.replace('uu','u')
    $Name = $Name.replace('yy','y')
    $Name = $Name.replace('kk','k')

    if(($Name -notlike "*a") -and ($Name -notlike "*e") -and ($Name -notlike "*i") -and ($Name -notlike "*o") -and ($Name -notlike "*u") -and ($Name -notlike "*y") -and ($Suffix -eq $false) -and ((Get-Random -Minimum 1 -Maximum 4) -eq 1)){$Name = "$($Name)y"}

    $Name

}
