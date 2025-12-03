$Prefixes = @("big","blink","rich","silly")
$OneSyllableRoots = ("bib","bob","bum","chit","cub","cup","did","dink","fib","flub","gig","glib","gum","hop","ingle","ink","jig","ken","ker","kin","kirk","link","lump","nab","nib","nip","nub","peck","pib","plump","plunk","pop","riff","tink","tum","wig","wink")
$MultipleSyllableRoots = @("bibble","bumble","chibi","chin","diddy","dimple","dingle","dumble","giggle","gummy","hiccup","itchker","nipper","nibble","ninny","nimble","patter","pebble","pepper","piddle","pitter","riffle","scoot","skip","sniff","sugar","thimble","tickle","tingle","tinkle","toddle","tom","trib","tummy","tummytum","wiggle","winkle")
$Roots = @()
$Roots += $OneSyllableRoots
$Roots += $MultipleSyllableRoots
$Suffixes = @("abble","abbit","bee"."bit","bob","bin","bun","chatter","chitter","chub","dumpling","ibble","iggle","in","ing","inker","it","itcher","ken","kin",,"knickers","let","lin","link","ling","lingur","nipper","ocky","piddle","pudding","nub","nubbin","rump","shick","sip","tom","wiff","wiggle")
$Vowels = @("a","i")

function Get-GnomeName {
    Param(
        [parameter(Mandatory=$False)]
        [bool]$Prefix,
        [parameter(Mandatory=$False)]
        [bool]$Suffix,
        [parameter(Mandatory=$False)]
        [string]$AdHoc
    )
    
    $Name = ''

    if(!$AdHoc){if((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}elseif((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = "$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])"}else{$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}}else{$Root = $AdHoc}

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

    #if(($Prefix -eq $true) -and (($Root -notlike "a*") -or ($Root -like "e*") -or ($Root -notlike "i*") -or ($Root -notlike "o*") -or ($Root -notlike "u*") -or ($Root -notlike "y*"))){$NamePrefix = "$($NamePrefix)$($Vowels[(Get-Random -Minimum 0 -Maximum ($Vowels.Count))])-"}
    if(($Prefix -eq $true) -and (($Root -notlike "a*") -or ($Root -like "e*") -or ($Root -notlike "i*") -or ($Root -notlike "o*") -or ($Root -notlike "u*") -or ($Root -notlike "y*"))){$NamePrefix = "$($NamePrefix)"}

    $Name = "$($NamePrefix)$($Root)$($NameSuffix)".ToLower()

    $Name = $Name.replace('aa','a')
    $Name = $Name.replace('ai','i')
    $Name = $Name.replace('ee','-e')
    if($NameSuffix -like "bee"){$Name = "$($Name.substring(0,($Name.Length -2)))bee"}
    
    if(($Name -like "*nubbins*") -or ($Name -like "*nibble*") -or ($Name -like "*abbit") -or ($Name -like "*pebble*")){
    
        $Name = $Name.replace('pebble','!!!')
        $Name = $Name.replace('nubbin','xxx')
        $Name = $Name.replace('nibble','zzz')
        $Name = $Name.replace('abbit','qqq')
        #$Name = $Name.replace('bb','b')
        $Name = $Name.replace('bbb','bb')
        $Name = $Name.replace('xxx','nubbin')
        $Name = $Name.replace('zzz','nibble')
        $Name = $Name.replace('qqq','abbit')
        $Name = $Name.replace('!!!','pebble')

    }else{
    
        $Name = $Name.replace('bb','b')
    
    }

    $Name = $Name.replace('bt','b-t')
    $Name = $Name.replace('bitch','b-itch')
    $Name = $Name.replace('ea','e-a')
    $Name = $Name.replace('ei','e-i')
    $Name = $Name.replace('hh','h-h')
    $Name = $Name.replace('ii','i')
    #$Name = $Name.replace('oo','o')
    $Name = $Name.replace('pb','p-b')
    $Name = $Name.replace('ph','p-h')
    $Name = $Name.replace('uu','u')
    $Name = $Name.replace('yy','y')
    $Name = $Name.replace('kk','k')
    $Name = $Name.replace('ppp','pp')
    $Name = $Name.replace('kn','kn')
    $Name = $Name.replace('kp','k-p')
    $Name = $Name.replace('kg','k-g')
    $Name = $Name.replace('gk','gg')
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

    if(($Name -notlike "*a") -and ($Name -notlike "*e") -and ($Name -notlike "*i") -and ($Name -notlike "*o") -and ($Name -notlike "*u") -and ($Name -notlike "*y") -and ($Name -notlike "*s") -and ((Get-Random -Minimum 1 -Maximum 3) -eq 1)){$Name = "$($Name)s"}
    if(($Name -notlike "*a") -and ($Name -notlike "*e") -and ($Name -notlike "*i") -and ($Name -notlike "*o") -and ($Name -notlike "*u") -and ($Name -notlike "*y") -and ($Name -notlike "*s") -and ($Suffix -eq $false) -and ((Get-Random -Minimum 1 -Maximum 4) -eq 1)){$Name = "$($Name)y"}
    if(($Name -like "*ny") -and ($Name -notlike "*nny")){$Name = "$($Name.Substring(0,($Name.Length - 2)))nny"}

    if($Name -like "*able"){
    
        $Roll = ''
        $Roll = Get-Random -Minimum 1 -Maximum 3

        if($Roll -eq 1){$Name = "$($Name.Substring(0,($Name.Length - 4)))$($Name.Substring(($Name.Length - 5),1))able"}else{$Name = "$($Name.Substring(0,($Name.Length - 4)))abble"}
        
    }

    if($Name -like "*nubin*"){$Name = $Name.replace('nubin','nubbin')}
    if($Name -like "*nubin*"){$Name = $Name.replace('nible','nibble')}

    if($Name -like "*bigit*"){$Name = $Name.replace('bigit','bibbit')}
    if($Name -like "*niggle*"){$Name = $Name.replace('niggle','bibble')}
    if($Name -like "*bible*"){$Name = $Name.replace('bible','bibble')}

    if($Name -like "*apin"){$Name = "$($Name.Substring(0,($Name.Length - 4)))appin"}
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
    
    if(($Name -like "*nny") -and ($Name -notlike "*nnny")){
    
        $Name = "$($Name.Substring(0,($Name.Length - 3)).replace('nn','n-n'))nny"

    }

    if($Name -like "*ninny*"){

        $Name = $Name.replace('ninny','xxx')
        $Name = $Name.replace('nn','n-n')
        $Name = $Name.replace('xxx','ninny')

    }else{
    
        #$Name = $Name.replace('nn','n-n')
    
    }

    if(($Name -like "*a-ings") -or ($Name -like "*e-ings") -or ($Name -like "*i-ings") -or ($Name -like "*o-ings") -or ($Name -like "*u-ings")){$Name = "$($Name.Substring(0,($Name.Length - 6)))ings"}
    if(($Name -like "*a-ing") -or ($Name -like "*e-ing") -or ($Name -like "*i-ing") -or ($Name -like "*o-ing") -or ($Name -like "*u-ing")){$Name = "$($Name.Substring(0,($Name.Length - 5)))ing"}

    $Name = "$($Name.Substring(0,1).ToUpper())"+"$($Name.Substring(1))"

    $Name

}

#####

$RockNouns = @("arrow","axe","beard","book","bottle","button","cap","cavern","clock","clog","coal","code","craft","crystal","drip","eye","finger","fire","fizzle","fungus","gear","gem","glimmer","glove","grub","hammer","hour","ink","key","law","ledger","letter","light","link","lock","lore","name","needle","nubbin","paper","pinky","print","quill","quiver","rock","ruin","rule","root","seal","shoe","shovel","shroom","song","screw","soup","spell","splinter","spring","song","stamp","steam","stone","story","study","sugar","thimble","thorn","thread","thumb","time","toe","tongue","tooth","tunnel","water","wax","wit","well","whistle","worm","wrench")
$RockAgents = @("bender","breaker","brow","caster","catcher","cooker","counter","crafter","cutter","digger","drinker","dripper","dropper","finder","fixer","grinder","hider","-inker","-itcher","judger","keeper","locker","picker","printer","puller","pusher","presser","maker","mender","quencher","reader","rooter","sealer","seeker","signer","sinker","snatcher","speaker","spinner","stamper","taster","teacher","teller","tender","thrower","tinker","tricker","twitcher","watcher","witcher","worker","writer")
$RockAdjectives = @("bad","bright","broken","chilly","clean","cold","dark","deep","dim","dizzy","double","dusty","fumble","funny","gold","good","hard","high","inky","itchy","long","lost","loud","low","magic","noble","over","pink","quick","short","silver","soft","soot","steady","sweet","tender","tiny","twitchy","under","twinkle","warm","wet","witty")

$ForestNouns = @("acorn","axe","autumn","bark","bean","beard","bed","bee","berry","bottle","bough","breeze","buckle","bud","bug","bulb","bush","butter","button","cap","circle","cloud","clover","color","craft","crystal","cup","dew","dream","drip","dusk","eye","flower","finger","fizzle","fungus","game","garden","germ","glade","glove","grass","grub","hearth","hive","home","honey","hunt","ivy","jam","leaf","light","lilly","lore","maple","moon","morning","moss","mud","mushroom","name","needle","nest","nubbin","nut","oak","patch","path","petal","pillow","pine","pinky","pipe","pond","prank","rain","root","sap","seed","shoe","shroom","shrub","sky","spice","song","soup","spell","splinter","song","sprig","spring","stem","stone","story","sugar","summer","sun","star","stick","stream","stump","syrup","thimble","thistle","thorn","thread","timber","trunk","thumb","toe","tongue","tooth","tree","twig","vision","water","wit","weed","well","whistle","willow","winter","wish","wisp","wode","wood")
$ForestAgents = @("breaker","caster","catcher","cooker","crafter","cutter","dreamer","drinker","dropper","feather","finder","fixer","flitter","friend","grinder","grower","hider","hunter","-itcher","keeper","knot","picker","planter","player","plucker","puller","pusher","presser","maker","mender","patcher","quencher","ranger","rooter","seeker","seer","signer","smoker","snatcher","speaker","splitter","spinner","stamper","stinger","stitcher","taster","teacher","teller","tender","thrower","tinker","tracker","trapper","tricker","tumbler","twitcher","vine","watcher","weeder","wisher","witcher","worker")
$ForestAdjectives = @("bad","bright","broken","chilly","clean","cold","cozy","dark","dizzy","double","fumble","funny","good","green","hard","high","itchy","long","lost","loud","low","magic","oak","over","pink","quick","shady","short","silver","soft","steady","sweet","tender","tiny","twitchy","twinkle","warm","wet","witty","wood")

function Get-GnomeSurname {
    
    Param(
        [parameter(Mandatory=$False)]
        [ValidateSet("Rock","Forest")]
        [string]$Type
    )

    if(!$Type){if((Get-Random -Minimum 1 -Maximum 3) -eq 1){$Type = "Rock"}else{$Type = "Forest"}}

    $Surname = ''

    if($Type -eq "Rock"){

        $Roll = ''
        $Roll = Get-Random -Minimum 1 -Maximum 3

        if($Roll -eq 1){
    
            $1 =''
            $1 = $RockAdjectives[(Get-Random -Minimum 0 -Maximum ($RockAdjectives.Count))]

            $2 = ''
            $2 = $RockAgents[(Get-Random -Minimum 0 -Maximum ($RockAgents.Count))]

            $Surname = "$($1)$(if($1[-1] -eq $2[0]){"-"})$($2)"
        
        }elseif($Roll -eq 2){
    
            $1 =''
            $1 = $RockNouns[(Get-Random -Minimum 0 -Maximum ($RockNouns.Count))]

            $2 = ''
            $2 = $RockAgents[(Get-Random -Minimum 0 -Maximum ($RockAgents.Count))]

            $Surname = "$($1)$(if($1[-1] -eq $2[0]){"-"})$($2)"

        }

    }

    if($Type -eq "Forest"){

        $Roll = ''
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Roll -eq 1){
    
            $1 =''
            $1 = $ForestAdjectives[(Get-Random -Minimum 0 -Maximum ($ForestAdjectives.Count))]

            $2 = ''
            $2 = $ForestAgents[(Get-Random -Minimum 0 -Maximum ($ForestAgents.Count))]

            $Surname = "$($1)$(if($1[-1] -eq $2[0]){"-"})$($2)"
        
        }elseif($Roll -eq 2){
    
            $1 =''
            $1 = $ForestNouns[(Get-Random -Minimum 0 -Maximum ($ForestNouns.Count))]

            $2 = ''
            $2 = $ForestAgents[(Get-Random -Minimum 0 -Maximum ($ForestAgents.Count))]

            $Surname = "$($1)$(if($1[-1] -eq $2[0]){"-"})$($2)"

        }elseif($Roll -eq 3){
    
            $1 =''
            $1 = $ForestNouns[(Get-Random -Minimum 0 -Maximum ($ForestNouns.Count))]

            $2 = ''
            $2 = $ForestNouns[(Get-Random -Minimum 0 -Maximum ($ForestNouns.Count))]

            $Surname = "$($1)$(if($1[-1] -eq $2[0]){"-"})$($2)"

        }

    }

    $Surname = "$($Surname.Substring(0,1).ToUpper())"+"$($Surname.Substring(1))"

    $Surname

}
