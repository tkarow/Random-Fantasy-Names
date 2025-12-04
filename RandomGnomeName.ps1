#This is a set of curated syllables, sounds, and words that reflect my idea of fantasy gnome name constructors. I've written logic to combine them into aesthetically pleasing names after iterating on the results. This is a work in progress, and subject to taste.

$Prefixes = @("blink","rich")
$OneSyllableRoots = ("bib","big","bit","bob","bum","chit","chum","cub","cup","did","dink","fib","flub","fun","gig","glib","gum","hop","ingle","ink","jig","ken","ker","kin","kirk","link","lump","nab","nib","nip","nub","peck","pib","pink","plump","plunk","pop","puff","riff","skip","sniff","tiff","tink","tub","tum","wig","wink")
$MultipleSyllableRoots = @("apple","bibble","bobbin","bumble","buddy","chibi","chin","diddy","dimple","dingle","dumble","fudgy","giggle","gummy","hiccup","itchker","jelly","mingle","nipper","nibble","ninny","nimble","noggin","patter","pebble","pepper","piddle","pitter","putter","riffle","rumple","scoot","silly","snuffle","sugar","thimble","thumper","tickle","tingle","tinkle","toddle","tom","trib","truffle","tumble","tummy","tummytum","wiggle","willy","winkle","wrinkle")
$Roots = @()
$Roots += $OneSyllableRoots
$Roots += $MultipleSyllableRoots
$Suffixes = @("abble","abbit","bee","belly","bit","bob","bin","bun","by","chatter","chitter","chub","dumpling","goggin","ibble","iggle","in","ing","inker","it","itcher","jenkin","ken","kin","knickers","let","lin","link","ling","lingur","nipper","ocky","perkin","piddle","pudding","nub","nubbin","rump","sby","shick","sip","tom","umpkin","wiff","wilkin","wiggle","wudger","wudgin")
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

   if($Prefix -eq $true){$Suffix = $false}

    if(!$AdHoc){if((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}elseif((Get-Random -Minimum 1 -Maximum 3) -eq 2){$Root = "$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])$($OneSyllableRoots[(Get-Random -Minimum 0 -Maximum ($OneSyllableRoots.Count))])"}else{$Root = $Roots[(Get-Random -Minimum 0 -Maximum ($Roots.Count))]}}else{$Root = $AdHoc}

    if(($OneSyllableRoots -contains $Root) -or ($MultipleSyllableRoots -contains $Root)){$Suffix = $true}

    if((($Prefix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 11) -eq 1)) -and ($Prefix -ne $false)){$Prefix = $true;$NamePrefix = $Prefixes[(Get-Random -Minimum 0 -Maximum ($Prefixes.Count))]}else{$NamePrefix=''}
    if((($Suffix -eq $true) -or ((Get-Random -Minimum 1 -Maximum 6) -gt 1) -and ($Suffix -ne $false))){$Suffix = $true;$NameSuffix = $Suffixes[(Get-Random -Minimum 0 -Maximum ($Suffixes.Count))]}else{$NameSuffix =''}

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
    $Name = $Name.replace('chch','ch-ch')
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
    $Name = $Name.replace('fff','ff')
    $Name = $Name.replace('rr','r')
    $Name = $Name.replace('ww','w')
    $Name = $Name.replace('yi','y-i')

    if($Name -like "*eumpkin*"){$Name = $Name.replace('eumpkin','e-umpkin')}
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

        if($Roll -eq 1){$Name = "$($Name.Substring(0,($Name.Length - 4)))$($Name.Substring(($Name.Length - 5),1))abble"}else{$Name = "$($Name.Substring(0,($Name.Length - 4)))abble"}
        
    }

    if($Name -like "*nubin*"){$Name = $Name.replace('nubin','nubbin')}
    if($Name -like "*nubin*"){$Name = $Name.replace('nible','nibble')}

    if($Name -like "*bigit*"){$Name = $Name.replace('bigit','bibbit')}
    if($Name -like "*chink*"){$Name = $Name.replace('chink','chin-k')}
    if($Name -like "*niggle*"){$Name = $Name.replace('niggle','bibble')}
    if($Name -like "*bible*"){$Name = $Name.replace('bible','bibble')}

    if($Name -like "*aby"){$Name = "$($Name.Substring(0,($Name.Length - 3)))abby"}
    if($Name -like "*apin"){$Name = "$($Name.Substring(0,($Name.Length - 4)))appin"}
    if($Name -like "*yble"){$Name = "$($Name.Substring(0,($Name.Length - 4)))efoot"}
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

$RockNouns = @("beard","bell","book","bottle","brass","buckle","buddy","bug","button","candle","candy","cane","cap","cavern","chime","chip","clock","clog","coal","copper","craft","crystal","dingle","drip","fault","finger","fire","fizzle","flip","flux","fumble","fungus","gear","gem","glimmer","glove","grub","hammer","hour","ink","jewel","key","lantern","law","ledger","lesson","letter","light","link","lock","lore","metal","mine","name","needle","nubbin","number","paper","pinky","pipe","print","quill","quiver","rock","ruby","ruin","rule","root","scuttle","seal","shoe","shovel","shroom","snack","song","screw","soup","spell","spring","song","stamp","steam","stone","story","study","sugar","thimble","thorn","thread","thumb","time","toe","tome","tongue","tooth","tummy","tunnel","water","wax","wit","well","whistle","worm","wrench")
$RockAgents = @("belly","bender","berger","binder","biter","bits","breaker","brow","buddy","buffer","caster","catcher","chiller","chipper","chum","climber","cooker","counter","crafter","cutter","dancer","digger","dinger","dripper","dropper","fellow","file","finder","fixer","giver","gnome","goggles","helmer","hemmer","heimer","hider","holder","home","hopper","-inker","-itcher","joker","judger","keeper","kicker","knocker","locker","lover","mate","monch","picker","puffer","pocket","polish","prank","printer","puller","pusher","presser","mallow","maker","mender","miner","noggin","putter","reader","rooter","scamp","sealer","seeker","setter","shaper","signer","sinker","snacker","snatcher","snipper","speaker","spinner","stamper","taster","teacher","teller","tender","thrower","thumper","tinker","tricker","tucker","twitcher","watcher","witcher","worker","writer")
$RockAdjectives = @("brass","bright","candy","cheery","clean","clever","cold","copper","crackle","crafty","deep","dizzy","double","dusty","fair","fault","frolic","funny","gem","gold","good","grumble","happy","hard","high","inky","itchy","long","lost","loud","low","magic","naughty","noble","old","over","quick","rusty","short","silver","sly","soft","soot","spore","steady","sweet","tender","tiny","twitchy","under","tricksy","twinkle","warm","wee","wet","witty")
#region The following arrays may be implemented in the future. Unsure.
$RockFriends = @()
$RockAnimalFriends = @("bug","grub","worm")
$RockFriends += $RockAnimals
$RockLocales = @()
#endregion

$ForestNouns = @("acorn","alder","apple","autumn","barb","bark","basket","bean","beard","bed","bee","beet","bell","belly","berry","birch","bloom","bobbin","bottle","bough","breeze","bubble","buckle","bud","buddy","bug","bulb","bur","bush","butter","button","candle","candy","cane","cap","cedar","cherry","chive","circle","cloud","clover","comb","conker","craft","cream","critter","crystal","cup","day","dingle","dew","dill","dream","drip","dusk","dwale","earth","egg","elder","elm","fern","flip","flower","field","fig","finger","fir","fizzle","forest","fruit","fumble","fungus","game","garden","garland","garlic","germ","ginger","glade","glove","grass","grub","harvest","hazel","hearth","hedge","hemlock","hive","holly","home","honey","horn","hunt","iris","ivy","jam","land","leaf","leek","light","lilly","litter","lore","magic","maple","marsh","meadow","melon","milk","mint","moon","morning","moss","mud","mushroom","needle","nest","nettle","night","nubbin","nut","oak","oath","onion","orchid","paddy","pansy","parsley","parsnip","patch","path","pea","peach","pepper","petal","pillow","pine","pinky","pipe","plum","pond","pot","prank","promise","prune","puddle","puff","pumpkin","rain","root","rose","sap","scuttle","seed","shade","shoe","shoot","shroom","shrub","sky","slug","snail","spice","snack","song","soup","spell","splinter","spore","song","sprig","spring","spud","spruce","stem","stone","story","sugar","summer","sun","star","stick","stream","stump","syrup","tater","tea","thimble","thistle","thorn","thread","timber","truffle","trunk","thumb","toe","tongue","tooth","tree","tuft","turnip","twig","vision","wall","water","wax","wind","wit","weed","well","whistle","willow","winter","wish","wisp","wode","wood","wort","yew")
$ForestAgents = @("belly","berry","biter","bits","brush","buddy","buzzer","caller","caster","catcher","chiller","chum","climber","cooker","crafter","critter","dancer","dinger","dreamer","dropper","fellow","field","finder","fixer","flicker","flitter","flower","friend","friend","friend","gnome","giver","grower","gum","heimer","helmer","hider","holder","home","hopper","hummer","hunter","-itcher","jelly","joker","juicer","keeper","knocker","knot","lover","mannin","mate","monch","namer","picker","pocket","planter","player","plucker","prank","puffer","puller","pusher","putter","maker","mallow","mender","noggin","patcher","ranger","rooter","sage","scamp","scratcher","seeker","seer","shaper","smoker","snacker","snatcher","speaker","splitter","spinner","stamper","stinger","stitcher","straw","taster","teacher","teller","tender","thrower","thumper","tinker","tracker","trapper","tricker","tucker","tumbler","tummy","twitcher","vine","wander","watcher","weaver","weeder","wicker","wisher","witcher","worker")
$ForestAdjectives = @("bright","butter","candy","cheery","clean","clever","cold","cozy","crafty","dizzy","double","early","fair","fey","frolic","funny","good","green","grumble","half","happy","hard","high","humming","itchy","jelly","long","lost","loud","low","magic","muddy","naughty","nutty","oak","over","puff","quick","shady","short","silver","sly","soft","spore","steady","stink","sugar","sweet","tender","thunder","tiny","tricksy","twitchy","twinkle","warm","wee","wild","witty","wood")
$ForestFriends = @()
$AllForestPlants = @("apple","bean","beet","berry","birch","bloom","bush","cedar","cherry","chive","clover","dill","dwale","elm","fern","flower","fig","fir","fruit","fungus","garlic","ginger","grass","hazel","hemlock","holly","iris","ivy","leek","lilly","maple","melon","mint","moss","mushroom","nettle","oak","onion","orchid","paddy","pansy","parsley","parsnip","pea","peach","pepper","pine","plum","pumpkin","rose","shroom","shrub","spud","tater","truffle","tree","turnip","weed","willow","wort","yew")
$ForestAnimalFriends = @("ant","badger","beaver","bee","beetle","bird","bug","bunny","cricket","duck","fawn","ferret","fox","frog","goose","grub","hare","hedgehog","mouse","moth","newt","owl","rabbit","robin","slug","snail","sparrow","squirrel","swan","toad","woodpecker","worm")
$ForestPlantFriends = @("berry","birch","bush","cedar","clover","elm","fern","flower","fig","fir","fruit","fungus","hazel","hemlock","holly","ivy","lilly","maple","moss","mushroom","nettle","oak","pansy","pine","shroom","shrub","truffle","tree","willow","yew")
$ForestFriends += $ForestAnimalFriends
$ForestFriends += $ForestPlantFriends
#region The following arrays may be implemented in the future. Unsure.
$ForestFoods = @("apple","bean","beet","berry","bug","butter","candy","cherry","chive","cream","dill","egg","fig","fruit","fungus","garlic","ginger","grub","gum","hazel","hemlock","honey","jam","leek","maple","melon","mint","mushroom","nettle","nut","onion","parsley","parsnip","pea","peach","pepper","plum","pumpkin","root","sap","seed","shroom","spice","soup","spud","sugar","syrup","tea","tater","truffle","turnip","water","wort")
$ForestLocales = @()
#endregion

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
        #Additional logic needed to make satisfying combinations of random nouns - increase Maximum to 5 once/if this is done
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Roll -eq 1){
    
            $1 =''
            $1 = $RockAdjectives[(Get-Random -Minimum 0 -Maximum ($RockAdjectives.Count))]

            $2 = ''
            $2 = $RockAgents[(Get-Random -Minimum 0 -Maximum ($RockAgents.Count))]
        
        }elseif($Roll -eq 2){
    
            $1 =''
            $1 = $RockNouns[(Get-Random -Minimum 0 -Maximum ($RockNouns.Count))]

            $2 = ''
            $2 = $RockAgents[(Get-Random -Minimum 0 -Maximum ($RockAgents.Count))]

            if($1 -eq $2.Substring(0,$2.Length - 2)){$1 = $RockAdjectives[(Get-Random -Minimum 0 -Maximum ($RockAdjectives.Count))]}

        }elseif($Roll -eq 3){
    
            $1 =''
            $1 = $RockAdjectives[(Get-Random -Minimum 0 -Maximum ($RockAdjectives.Count))]

            $2 = ''
            $2 = $RockNouns[(Get-Random -Minimum 0 -Maximum ($RockNouns.Count))]

            if($1 -eq $2){$2 = $RockAgents[(Get-Random -Minimum 0 -Maximum ($RockAgents.Count))]}

        #Additional logic needed to make satisfying combinations of random nouns
        }elseif($Roll -eq 4){
    
            $1 =''
            $1 = $RockNouns[(Get-Random -Minimum 0 -Maximum ($RockNouns.Count))]

            $2 = ''
            $2 = $RockNouns[(Get-Random -Minimum 0 -Maximum ($RockNouns.Count))]

            if($1 -eq $2){$2 = $RockAgents[(Get-Random -Minimum 0 -Maximum ($RockAgents.Count))]}

        }

    }

    if($Type -eq "Forest"){

        $Roll = ''
        #Additional logic needed to make satisfying combinations of random nouns - increase Maximum to 5 once/if this is done
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Roll -eq 1){
    
            $1 =''
            $1 = $ForestAdjectives[(Get-Random -Minimum 0 -Maximum ($ForestAdjectives.Count))]

            $2 = ''
            $2 = $ForestAgents[(Get-Random -Minimum 0 -Maximum ($ForestAgents.Count))]

        }elseif($Roll -eq 2){
    
            $1 =''
            $1 = $ForestNouns[(Get-Random -Minimum 0 -Maximum ($ForestNouns.Count))]

            $2 = ''
            $2 = $ForestAgents[(Get-Random -Minimum 0 -Maximum ($ForestAgents.Count))]

            if($1 -eq $2.Substring(0,$2.Length - 2)){$1 = $ForestAdjectives[(Get-Random -Minimum 0 -Maximum ($ForestAdjectives.Count))]}

        #Additional logic needed to make satisfying combinations of random nouns
        }elseif($Roll -eq 3){
    
            $1 =''
            $1 = $ForestAdjectives[(Get-Random -Minimum 0 -Maximum ($ForestAdjectives.Count))]

            $2 = ''
            $2 = $ForestNouns[(Get-Random -Minimum 0 -Maximum ($ForestNouns.Count))]

            if($1 -eq $2){$2 = $ForestAgents[(Get-Random -Minimum 0 -Maximum ($ForestAgents.Count))]}

        #Additional logic needed to make satisfying combinations of random nouns
        }elseif($Roll -eq 4){
    
            $1 =''
            $1 = $ForestNouns[(Get-Random -Minimum 0 -Maximum ($ForestNouns.Count))]

            $2 = ''
            $2 = $ForestNouns[(Get-Random -Minimum 0 -Maximum ($ForestNouns.Count))]

            if($1 -eq $2){$2 = $ForestAgents[(Get-Random -Minimum 0 -Maximum ($ForestAgents.Count))]}

        }

        if($2 -like "friend"){$1 = $ForestFriends[(Get-Random -Minimum 0 -Maximum ($ForestFriends.Count))]}

    }

    if($1[-1] -eq $2[0]){$Surname = "$($1)-$($2)"}else{$Surname = "$($1)$($2)"}

    if(($1[-1] -eq "t") -and ($2[0] -eq "h")){$Surname = "$($1)-$($2)"}

    $Surname = "$($Surname.Substring(0,1).ToUpper())"+"$($Surname.Substring(1))"

    $Surname

}
