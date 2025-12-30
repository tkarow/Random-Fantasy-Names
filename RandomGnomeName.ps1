#This is a set of curated syllables, sounds, and words that reflect my idea of fantasy gnome name constructors. I've written logic to combine them into aesthetically pleasing names after iterating on the results. This is a work in progress, and subject to taste.
#Shoutout to tophonetics.com for the (American) IPA phonetic transcriptions

#################
#################
##             ##
## First Names ##
##             ##
#################
#################

$Prefixes = @("blink","rich")
$OneSyllableRoots = ("bib","big","bink","bit","bob","bum","chit","chum","cub","cup","did","dink","fib","flub","fun","gig","glib","gum","hop","ingle","ink","jig","ken","ker","kin","kirk","link","lump","nab","nib","nip","nub","peck","pib","pink","plump","plunk","pop","puff","riff","skip","sniff","tiff","tink","tub","tum","wig","wink")
$MultipleSyllableRoots = @("apple","bibble","bobbin","bumble","buddy","chibi","chin","diddy","dimple","dingle","dumble","fudgy","giggle","gummy","hiccup","itchker","jelly","mingle","nipper","nibble","ninny","nimble","noggin","patter","pebble","pepper","piddle","pitter","putter","riffle","rumple","scoot","silly","snicker","snuffle","sugar","thimble","tiddly","thumper","tickle","tingle","tinkle","toddle","tom","trib","truffle","tumble","tummy","tummytum","wiggle","willy","winkle","wrinkle")
$Roots = @()
$Roots += $OneSyllableRoots
$Roots += $MultipleSyllableRoots
$Suffixes = @("abble","abbit","bee","bit","bob","bin","bun","by","chatter","chitter","chub","doodle","goggin","ibble","iggle","in","ing","inker","it","itcher","jenkin","ken","kin","let","lin","link","ling","lingur","nipper","ocky","perkin","piddle","pudding","nub","sby","shick","sip","tom","umpkin","wiff","wilkin","wiggle","wink","wudger","wudgin")
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

<#
$RockNouns = @("aim","angle","bang","bauble","beard","bell","belly","belt","bench","book","boot","bottle","brass","buckle","buddy","bug","button","candle","candy","cane","cap","cavern","chime","chip","chortle","clock","clog","coal","cog","copper","craft","crate","crumb","cubby","crystal","cycle","design","dial","dingle","doodad","drill","drip","engine","fault","figure","finger","fire","fizzle","flange","flip","flux","fumble","fungus","fuse","gadget","garnet","gas","gavel","gear","gem","gimmick","gizmo","glimmer","glove","grub","hammer","hatch","hour","ink","jig","jewel","key","knack","lantern","law","ledger","lesson","letter","light","link","lock","lore","map","mind","mine","measure","metal","mill","mine","name","needle","notch","nubbin","number","pack","paper","pattern","pin","pinky","pipe","plan","pocket","print","project","pulley","quartz","quill","quiver","rack","rascal","ratchet","rock","ruby","ruin","rule","rump","rust","root","sapphire","saw","scheme","school","screw","scuttle","seal","set","shoe","shop","shovel","shroom","slot","smock","snack","song","soot","soup","spell","spring","spunk","song","sprocket","stamp","steam","stone","story","study","sugar","switch","system","tally","thimble","thingy","thread","thumb","time","toe","tome","tongue","tooth","tool","toy","trick","trinket","tummy","tunnel","wagon","wax","way","whatsit","widget","wit","well","wheel","whistle","work","worm","wrench")
$RockAgents = @("belly","bender","berger","binder","biter","bits","breaker","brow","buddy","buffer","builder","caster","catcher","checker","chiller","chipper","chum","climber","clunker","cotter","counter","crafter","cutter","dancer","digger","driller","dinger","dripper","dropper","fellow","file","finder","fixer","framer","fuser","giver","glitter","gnome","goggles","helmer","hemmer","heimer","hider","holder","home","hopper","-inker","-itcher","jigger","joker","judger","keeper","kicker","knacker","knickers","knocker","locker","lover","mapper","mate","meister","meter","meyer","monch","more","muncher","nacker","packer","pants","picker","plotter","puffer","pocket","polish","prank","printer","puller","puncher","pusher","presser","maker","mallow","maker","marker","mender","miner","noggin","officer","planner","pocket","putter","reader","roller","rooter","scamp","scooper","sealer","seeker","setter","shaper","sharer","shiner","signer","sinker","snacker","snatcher","snipper","speaker","spinner","stamper","stopper","sweeper","taster","teacher","teller","tender","thrower","thumper","ticker","tinker","tricker","tucker","twitcher","watcher","winder","witcher","worker","writer")
$RockAdjectives = @("best","brass","bright","candy","cheery","chitty","chrome","clean","clever","cold","copper","crackle","crafty","crumb","deep","dizzy","double","drive","dusty","fair","fault","fraggle","frolic","funny","gem","gold","good","grumble","happy","hard","high","inky","itchy","knotty","long","lost","loud","low","magic","munch","naughty","next","noble","odd","old","over","pocket","power","quartz","quick","rusty","safe","short","silver","sledge","sly","soft","soot","spore","steady","strict","sweet","tender","tinker","tiny","top","trick","tricksy","twitchy","under","twinkle","warm","wee","witty","wonder","work") 

$RockAlliteritiveNounUniques = $RockNouns | sort | %{$_[0]} | Get-Unique
$RockAlliteritiveAgentUniques = $RockAgents | sort | %{$_[0]} | Get-Unique
$RockAlliteritiveAdjectiveUniques = $RockAdjectives | sort | %{$_[0]} | Get-Unique
#>

#region The following arrays may be implemented in the future. Unsure.
$RockFriends = @()
$RockAnimalFriends = @("ant","bug","grub","worm")
$RockPlantFriends = @("mushroom","root","shroom")
$RockFriends += $RockAnimalFriends
$RockFriends += $RockPlantFriends
$RockLocales = @("class","cavern","mine","office","sċool","shop","tunnel")
$RockFluids = @("oil","water")
#endregion

#region Expansion

##########################
##########################
##                      ##
## Surname Constructors ##
##                      ##
##########################
##########################

######
#Rock#
######

$RockNounObjects = @(

    	[pscustomobject]@{
			Word=“aim";
			IPA="eɪm"
		},
		[pscustomobject]@{
			Word=“angle";
			IPA="ˈæŋɡəl"
		},
		[pscustomobject]@{
			Word=“bang";
			IPA="bæŋ"
		},
		[pscustomobject]@{
			Word=“bauble";
			IPA="ˈbɔbəl"
		},
		[pscustomobject]@{
			Word=“beard";
			IPA="bɪrd"
		},
		[pscustomobject]@{
			Word=“bell";
			IPA="bɛl"
		},
		[pscustomobject]@{
			Word=“belly";
			IPA="ˈbɛli"
		},
		[pscustomobject]@{
			Word=“belt";
			IPA="bɛlt"
		},
		[pscustomobject]@{
			Word=“bench";
			IPA="bɛnʧ"
		},
		[pscustomobject]@{
			Word=“book";
			IPA="bʊk"
		},
		[pscustomobject]@{
			Word=“boot";
			IPA="but"
		},
		[pscustomobject]@{
			Word=“bottle";
			IPA="ˈbɑtəl"
		},
		[pscustomobject]@{
			Word=“brass";
			IPA="bræs"
		},
		[pscustomobject]@{
			Word=“buckle";
			IPA="ˈbʌkəl"
		},
		[pscustomobject]@{
			Word=“buddy";
			IPA="ˈbʌdi"
		},
		[pscustomobject]@{
			Word=“bug";
			IPA="bʌɡ"
		},
		[pscustomobject]@{
			Word=“button";
			IPA="ˈbʌtən"
		},
		[pscustomobject]@{
			Word=“candle";
			IPA="ˈkændəl"
		},
		[pscustomobject]@{
			Word=“candy";
			IPA="ˈkændi"
		},
		[pscustomobject]@{
			Word=“cane";
			IPA="keɪn"
		},
		[pscustomobject]@{
			Word=“cap";
			IPA="kæp"
		},
		[pscustomobject]@{
			Word=“cavern";
			IPA="ˈkævərn"
		},
		[pscustomobject]@{
			Word=“chime";
			IPA="ʧaɪm"
		},
		[pscustomobject]@{
			Word=“chip";
			IPA="ʧɪp"
		},
		[pscustomobject]@{
			Word=“chortle";
			IPA="ˈʧɔrtəl"
		},
		[pscustomobject]@{
			Word=“clock";
			IPA="klɑk"
		},
		[pscustomobject]@{
			Word=“clog";
			IPA="klɑɡ"
		},
		[pscustomobject]@{
			Word=“coal";
			IPA="koʊl"
		},
		[pscustomobject]@{
			Word=“cog";
			IPA="kɔɡ"
		},
		[pscustomobject]@{
			Word=“copper";
			IPA="ˈkɑpər"
		},
		[pscustomobject]@{
			Word=“craft";
			IPA="kræft"
		},
		[pscustomobject]@{
			Word=“crate";
			IPA="kreɪt"
		},
		[pscustomobject]@{
			Word=“crumb";
			IPA="krʌm"
		},
		[pscustomobject]@{
			Word=“cubby";
			IPA="kʌbi"
		},
		[pscustomobject]@{
			Word=“crystal";
			IPA="ˈkrɪstəl"
		},
		[pscustomobject]@{
			Word=“cycle";
			IPA="ˈsaɪkəl"
		},
		[pscustomobject]@{
			Word=“design";
			IPA="dɪˈzaɪn"
		},
		[pscustomobject]@{
			Word=“dial";
			IPA="ˈdaɪəl"
		},
		[pscustomobject]@{
			Word=“dingle";
			IPA="ˈdɪŋɡəl"
		},
		[pscustomobject]@{
			Word=“doodad";
			IPA="ˈduˌdæd"
		},
		[pscustomobject]@{
			Word=“drill";
			IPA="drɪl"
		},
		[pscustomobject]@{
			Word=“drip";
			IPA="drɪp"
		},
		[pscustomobject]@{
			Word=“engine";
			IPA="ˈɛnʤən"
		},
		[pscustomobject]@{
			Word=“fault";
			IPA="fɔlt"
		},
		[pscustomobject]@{
			Word=“figure";
			IPA="ˈfɪɡjər"
		},
		[pscustomobject]@{
			Word=“finger";
			IPA="ˈfɪŋɡər"
		},
		[pscustomobject]@{
			Word=“fire";
			IPA="faɪr"
		},
		[pscustomobject]@{
			Word=“fizzle";
			IPA="ˈfɪzəl"
		},
		[pscustomobject]@{
			Word=“flange";
			IPA="flænʤ"
		},
		[pscustomobject]@{
			Word=“flip";
			IPA="flɪp"
		},
		[pscustomobject]@{
			Word=“flux";
			IPA="flʌks"
		},
		[pscustomobject]@{
			Word=“fumble";
			IPA="ˈfʌmbəl"
		},
		[pscustomobject]@{
			Word=“fungus";
			IPA="ˈfʌŋɡəs"
		},
		[pscustomobject]@{
			Word=“fuse";
			IPA="fjuz"
		},
		[pscustomobject]@{
			Word=“gadget";
			IPA="ˈɡæʤət"
		},
		[pscustomobject]@{
			Word=“garnet";
			IPA="ˈɡɑrnət"
		},
		[pscustomobject]@{
			Word=“gas";
			IPA="ɡæs"
		},
		[pscustomobject]@{
			Word=“gavel";
			IPA="ˈɡævəl"
		},
		[pscustomobject]@{
			Word=“gear";
			IPA="ɡɪr"
		},
		[pscustomobject]@{
			Word=“gem";
			IPA="ʤɛm"
		},
		[pscustomobject]@{
			Word=“gimmick";
			IPA="ˈɡɪmɪk"
		},
		[pscustomobject]@{
			Word=“gizmo";
			IPA="ˈɡɪzˌmoʊ"
		},
		[pscustomobject]@{
			Word=“glimmer";
			IPA="ˈɡlɪmər"
		},
		[pscustomobject]@{
			Word=“glove";
			IPA="ɡlʌv"
		},
		[pscustomobject]@{
			Word=“grub";
			IPA="ɡrʌb"
		},
		[pscustomobject]@{
			Word=“hammer";
			IPA="ˈhæmər"
		},
		[pscustomobject]@{
			Word=“hatch";
			IPA="hæʧ"
		},
		[pscustomobject]@{
			Word=“hour";
			IPA="ˈaʊər"
		},
		[pscustomobject]@{
			Word=“ink";
			IPA="ɪŋk"
		},
		[pscustomobject]@{
			Word=“jig";
			IPA="ʤɪɡ"
		},
		[pscustomobject]@{
			Word=“jewel";
			IPA="ˈʤuəl"
		},
		[pscustomobject]@{
			Word=“key";
			IPA="ki"
		},
		[pscustomobject]@{
			Word=“knack";
			IPA="næk"
		},
		[pscustomobject]@{
			Word=“lantern";
			IPA="ˈlæntərn"
		},
		[pscustomobject]@{
			Word=“law";
			IPA="lɔ"
		},
		[pscustomobject]@{
			Word=“ledger";
			IPA="ˈlɛʤər"
		},
		[pscustomobject]@{
			Word=“lesson";
			IPA="ˈlɛsən"
		},
		[pscustomobject]@{
			Word=“letter";
			IPA="ˈlɛtər"
		},
		[pscustomobject]@{
			Word=“light";
			IPA="laɪt"
		},
		[pscustomobject]@{
			Word=“link";
			IPA="lɪŋk"
		},
		[pscustomobject]@{
			Word=“lock";
			IPA="lɑk"
		},
		[pscustomobject]@{
			Word=“lore";
			IPA="lɔr"
		},
		[pscustomobject]@{
			Word=“map";
			IPA="mæp"
		},
		[pscustomobject]@{
			Word=“mind";
			IPA="maɪnd"
		},
		[pscustomobject]@{
			Word=“mine";
			IPA="maɪn"
		},
		[pscustomobject]@{
			Word=“measure";
			IPA="ˈmɛʒər"
		},
		[pscustomobject]@{
			Word=“metal";
			IPA="ˈmɛtəl"
		},
		[pscustomobject]@{
			Word=“mill";
			IPA="mɪl"
		},
		[pscustomobject]@{
			Word=“name";
			IPA="neɪm"
		},
		[pscustomobject]@{
			Word=“needle";
			IPA="ˈnidəl"
		},
		[pscustomobject]@{
			Word=“notch";
			IPA="nɑʧ"
		},
		[pscustomobject]@{
			Word=“nubbin";
			IPA="ˈnʌbɪn"
		},
		[pscustomobject]@{
			Word=“number";
			IPA="ˈnʌmbər"
		},
		[pscustomobject]@{
			Word=“pack";
			IPA="pæk"
		},
		[pscustomobject]@{
			Word=“paper";
			IPA="ˈpeɪpər"
		},
		[pscustomobject]@{
			Word=“pattern";
			IPA="ˈpætərn"
		},
		[pscustomobject]@{
			Word=“pin";
			IPA="pɪn"
		},
		[pscustomobject]@{
			Word=“pinky";
			IPA="ˈpɪŋki"
		},
		[pscustomobject]@{
			Word=“pipe";
			IPA="paɪp"
		},
		[pscustomobject]@{
			Word=“plan";
			IPA="plæn"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“print";
			IPA="prɪnt"
		},
		[pscustomobject]@{
			Word=“project";
			IPA="ˈprɑʤɛkt"
		},
		[pscustomobject]@{
			Word=“pulley";
			IPA="ˈpʊli"
		},
		[pscustomobject]@{
			Word=“quartz";
			IPA="kwɔrts"
		},
		[pscustomobject]@{
			Word=“quill";
			IPA="kwɪl"
		},
		[pscustomobject]@{
			Word=“quiver";
			IPA="ˈkwɪvər"
		},
		[pscustomobject]@{
			Word=“rack";
			IPA="ræk"
		},
		[pscustomobject]@{
			Word=“rascal";
			IPA="ˈræskəl"
		},
		[pscustomobject]@{
			Word=“ratchet";
			IPA="ˈræʧət"
		},
		[pscustomobject]@{
			Word=“rock";
			IPA="rɑk"
		},
		[pscustomobject]@{
			Word=“ruby";
			IPA="ˈrubi"
		},
		[pscustomobject]@{
			Word=“ruin";
			IPA="ˈruɪn"
		},
		[pscustomobject]@{
			Word=“rule";
			IPA="rul"
		},
		[pscustomobject]@{
			Word=“rump";
			IPA="rʌmp"
		},
		[pscustomobject]@{
			Word=“rust";
			IPA="rʌst"
		},
		[pscustomobject]@{
			Word=“root";
			IPA="rut"
		},
		[pscustomobject]@{
			Word=“sapphire";
			IPA="ˈsæfaɪər"
		},
		[pscustomobject]@{
			Word=“saw";
			IPA="sɔ"
		},
		[pscustomobject]@{
			Word=“scheme";
			IPA="skim"
		},
		[pscustomobject]@{
			Word=“school";
			IPA="skul"
		},
		[pscustomobject]@{
			Word=“screw";
			IPA="skru"
		},
		[pscustomobject]@{
			Word=“scuttle";
			IPA="ˈskʌtəl"
		},
		[pscustomobject]@{
			Word=“seal";
			IPA="sil"
		},
		[pscustomobject]@{
			Word=“set";
			IPA="sɛt"
		},
		[pscustomobject]@{
			Word=“shoe";
			IPA="ʃu"
		},
		[pscustomobject]@{
			Word=“shop";
			IPA="ʃɑp"
		},
		[pscustomobject]@{
			Word=“shovel";
			IPA="ˈʃʌvəl"
		},
		[pscustomobject]@{
			Word=“shroom";
			IPA="ʃɹuːm"
		},
		[pscustomobject]@{
			Word=“slot";
			IPA="slɑt"
		},
		[pscustomobject]@{
			Word=“smock";
			IPA="smɑk"
		},
		[pscustomobject]@{
			Word=“snack";
			IPA="snæk"
		},
		[pscustomobject]@{
			Word=“song";
			IPA="sɔŋ"
		},
		[pscustomobject]@{
			Word=“soot";
			IPA="sʊt"
		},
		[pscustomobject]@{
			Word=“soup";
			IPA="sup"
		},
		[pscustomobject]@{
			Word=“spell";
			IPA="spɛl"
		},
		[pscustomobject]@{
			Word=“spring";
			IPA="sprɪŋ"
		},
		[pscustomobject]@{
			Word=“spunk";
			IPA="spʌŋk"
		},
		[pscustomobject]@{
			Word=“song";
			IPA="sɔŋ"
		},
		[pscustomobject]@{
			Word=“sprocket";
			IPA="ˈsprɑkət"
		},
		[pscustomobject]@{
			Word=“stamp";
			IPA="stæmp"
		},
		[pscustomobject]@{
			Word=“steam";
			IPA="stim"
		},
		[pscustomobject]@{
			Word=“stone";
			IPA="stoʊn"
		},
		[pscustomobject]@{
			Word=“story";
			IPA="ˈstɔri"
		},
		[pscustomobject]@{
			Word=“study";
			IPA="ˈstʌdi"
		},
		[pscustomobject]@{
			Word=“sugar";
			IPA="ˈʃʊɡər"
		},
		[pscustomobject]@{
			Word=“switch";
			IPA="swɪʧ"
		},
		[pscustomobject]@{
			Word=“system";
			IPA="ˈsɪstəm"
		},
		[pscustomobject]@{
			Word=“tally";
			IPA="ˈtæli"
		},
		[pscustomobject]@{
			Word=“thimble";
			IPA="ˈθɪmbəl"
		},
		[pscustomobject]@{
			Word=“thingy";
			IPA="ˈθɪŋi"
		},
		[pscustomobject]@{
			Word=“thread";
			IPA="θrɛd"
		},
		[pscustomobject]@{
			Word=“thumb";
			IPA="θʌm"
		},
		[pscustomobject]@{
			Word=“time";
			IPA="taɪm"
		},
		[pscustomobject]@{
			Word=“toe";
			IPA="toʊ"
		},
		[pscustomobject]@{
			Word=“tome";
			IPA="toʊm"
		},
		[pscustomobject]@{
			Word=“tongue";
			IPA="tʌŋ"
		},
		[pscustomobject]@{
			Word=“tooth";
			IPA="tuθ"
		},
		[pscustomobject]@{
			Word=“tool";
			IPA="tul"
		},
		[pscustomobject]@{
			Word=“toy";
			IPA="tɔɪ"
		},
		[pscustomobject]@{
			Word=“trick";
			IPA="trɪk"
		},
		[pscustomobject]@{
			Word=“trinket";
			IPA="ˈtrɪŋkət"
		},
		[pscustomobject]@{
			Word=“tummy";
			IPA="ˈtʌmi"
		},
		[pscustomobject]@{
			Word=“tunnel";
			IPA="ˈtʌnəl"
		},
		[pscustomobject]@{
			Word=“wagon";
			IPA="ˈwæɡən"
		},
		[pscustomobject]@{
			Word=“wax";
			IPA="wæks"
		},
		[pscustomobject]@{
			Word=“way";
			IPA="weɪ"
		},
		[pscustomobject]@{
			Word=“whatsit";
			IPA="wʌtˈsɪt"
		},
		[pscustomobject]@{
			Word=“widget";
			IPA="ˈwɪʤɪt"
		},
		[pscustomobject]@{
			Word=“wit";
			IPA="wɪt"
		},
		[pscustomobject]@{
			Word=“well";
			IPA="wɛl"
		},
		[pscustomobject]@{
			Word=“wheel";
			IPA="wil"
		},
		[pscustomobject]@{
			Word=“whistle";
			IPA="ˈwɪsəl"
		},
		[pscustomobject]@{
			Word=“work";
			IPA="wɜrk"
		},
		[pscustomobject]@{
			Word=“worm";
			IPA="wɜrm"
		},
		[pscustomobject]@{
			Word=“wrench";
			IPA="rɛnʧ"
		}

    )

$RockAgentObjects = @(
    	[pscustomobject]@{
			Word=“belly";
			IPA="ˈbɛli"
		},
		[pscustomobject]@{
			Word=“bender";
			IPA="ˈbɛndər"
		},
		[pscustomobject]@{
			Word=“berger";
			IPA="ˈbɜrɡər"
		},
		[pscustomobject]@{
			Word=“binder";
			IPA="ˈbaɪndər"
		},
		[pscustomobject]@{
			Word=“biter";
			IPA="ˈbaɪtər"
		},
		[pscustomobject]@{
			Word=“bits";
			IPA="bɪts"
		},
		[pscustomobject]@{
			Word=“breaker";
			IPA="ˈbreɪkər"
		},
		[pscustomobject]@{
			Word=“brow";
			IPA="braʊ"
		},
		[pscustomobject]@{
			Word=“buddy";
			IPA="ˈbʌdi"
		},
		[pscustomobject]@{
			Word=“buffer";
			IPA="ˈbʌfər"
		},
		[pscustomobject]@{
			Word=“builder";
			IPA="ˈbɪldər"
		},
		[pscustomobject]@{
			Word=“caster";
			IPA="ˈkæstər"
		},
		[pscustomobject]@{
			Word=“catcher";
			IPA="ˈkæʧər"
		},
		[pscustomobject]@{
			Word=“checker";
			IPA="ˈʧɛkər"
		},
		[pscustomobject]@{
			Word=“chiller";
			IPA="ˈʧɪlər"
		},
		[pscustomobject]@{
			Word=“chipper";
			IPA="ˈʧɪpər"
		},
		[pscustomobject]@{
			Word=“chum";
			IPA="ʧʌm"
		},
		[pscustomobject]@{
			Word=“climber";
			IPA="ˈklaɪmər"
		},
		[pscustomobject]@{
			Word=“clunker";
			IPA="ˈklʌŋkər"
		},
		[pscustomobject]@{
			Word=“cotter";
			IPA="ˈkɑtər"
		},
		[pscustomobject]@{
			Word=“counter";
			IPA="ˈkaʊntər"
		},
		[pscustomobject]@{
			Word=“crafter";
			IPA="ˈkræftər"
		},
		[pscustomobject]@{
			Word=“cutter";
			IPA="ˈkʌtər"
		},
		[pscustomobject]@{
			Word=“dancer";
			IPA="ˈdænsər"
		},
		[pscustomobject]@{
			Word=“digger";
			IPA="ˈdɪɡər"
		},
		[pscustomobject]@{
			Word=“driller";
			IPA="ˈdrɪlər"
		},
		[pscustomobject]@{
			Word=“dinger";
			IPA="ˈdɪŋər"
		},
		[pscustomobject]@{
			Word=“dripper";
			IPA="ˈdrɪpər"
		},
		[pscustomobject]@{
			Word=“dropper";
			IPA="ˈdrɑpər"
		},
		[pscustomobject]@{
			Word=“fellow";
			IPA="ˈfɛloʊ"
		},
		[pscustomobject]@{
			Word=“file";
			IPA="faɪl"
		},
		[pscustomobject]@{
			Word=“finder";
			IPA="ˈfaɪndər"
		},
		[pscustomobject]@{
			Word=“fixer";
			IPA="ˈfɪksər"
		},
		[pscustomobject]@{
			Word=“framer";
			IPA="ˈfreɪmər"
		},
		[pscustomobject]@{
			Word=“fuser";
			IPA="ˈfjuzər"
		},
		[pscustomobject]@{
			Word=“giver";
			IPA="ˈɡɪvər"
		},
		[pscustomobject]@{
			Word=“glitter";
			IPA="ˈɡlɪtər"
		},
		[pscustomobject]@{
			Word=“gnome";
			IPA="noʊm"
		},
		[pscustomobject]@{
			Word=“goggles";
			IPA="ˈɡɑɡəlz"
		},
		[pscustomobject]@{
			Word=“helmer";
			IPA="ˈhɛlmər"
		},
		[pscustomobject]@{
			Word=“hemmer";
			IPA="ˈhɛmər"
		},
		[pscustomobject]@{
			Word=“heimer";
			IPA="ˈhaɪmər"
		},
		[pscustomobject]@{
			Word=“hider";
			IPA="ˈhaɪdər"
		},
		[pscustomobject]@{
			Word=“holder";
			IPA="ˈhoʊldər"
		},
		[pscustomobject]@{
			Word=“home";
			IPA="hoʊm"
		},
		[pscustomobject]@{
			Word=“hopper";
			IPA="ˈhɑpər"
		},
		[pscustomobject]@{
			Word=“inker";
			IPA="ˈɪŋkər"
		},
		[pscustomobject]@{
			Word=“itcher";
			IPA="ˈɪʧər"
		},
		[pscustomobject]@{
			Word=“jigger";
			IPA="ˈʤɪɡər"
		},
		[pscustomobject]@{
			Word=“joker";
			IPA="ˈʤoʊkər"
		},
		[pscustomobject]@{
			Word=“judger";
			IPA="ˈʤʌʤər"
		},
		[pscustomobject]@{
			Word=“keeper";
			IPA="ˈkipər"
		},
		[pscustomobject]@{
			Word=“kicker";
			IPA="ˈkɪkər"
		},
		[pscustomobject]@{
			Word=“knacker";
			IPA="ˈnækər"
		},
		[pscustomobject]@{
			Word=“knickers";
			IPA="ˈnɪkərz"
		},
		[pscustomobject]@{
			Word=“knocker";
			IPA="ˈnɑkər"
		},
		[pscustomobject]@{
			Word=“locker";
			IPA="ˈlɑkər"
		},
		[pscustomobject]@{
			Word=“lover";
			IPA="ˈlʌvər"
		},
		[pscustomobject]@{
			Word=“mapper";
			IPA="ˈmæpər"
		},
		[pscustomobject]@{
			Word=“mate";
			IPA="meɪt"
		},
		[pscustomobject]@{
			Word=“meister";
			IPA="ˈmaɪstər"
		},
		[pscustomobject]@{
			Word=“meter";
			IPA="ˈmitər"
		},
		[pscustomobject]@{
			Word=“meyer";
			IPA="ˈmaɪər"
		},
		[pscustomobject]@{
			Word=“monch";
			IPA="mœnç"
		},
		[pscustomobject]@{
			Word=“more";
			IPA="mɔr"
		},
		[pscustomobject]@{
			Word=“muncher";
			IPA="ˈmʌnʧər"
		},
		[pscustomobject]@{
			Word=“nacker";
			IPA="ˈnækər"
		},
		[pscustomobject]@{
			Word=“packer";
			IPA="ˈpækər"
		},
		[pscustomobject]@{
			Word=“pants";
			IPA="pænts"
		},
		[pscustomobject]@{
			Word=“picker";
			IPA="ˈpɪkər"
		},
		[pscustomobject]@{
			Word=“plotter";
			IPA="ˈplɑtər"
		},
		[pscustomobject]@{
			Word=“puffer";
			IPA="ˈpʌfər"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“polish";
			IPA="ˈpɑlɪʃ"
		},
		[pscustomobject]@{
			Word=“prank";
			IPA="præŋk"
		},
		[pscustomobject]@{
			Word=“printer";
			IPA="ˈprɪntər"
		},
		[pscustomobject]@{
			Word=“puller";
			IPA="ˈpʊlər"
		},
		[pscustomobject]@{
			Word=“puncher";
			IPA="ˈpʌnʧər"
		},
		[pscustomobject]@{
			Word=“pusher";
			IPA="ˈpʊʃər"
		},
		[pscustomobject]@{
			Word=“presser";
			IPA="ˈprɛsər"
		},
		[pscustomobject]@{
			Word=“maker";
			IPA="ˈmeɪkər"
		},
		[pscustomobject]@{
			Word=“mallow";
			IPA="ˈmæloʊ"
		},
		[pscustomobject]@{
			Word=“maker";
			IPA="ˈmeɪkər"
		},
		[pscustomobject]@{
			Word=“marker";
			IPA="ˈmɑrkər"
		},
		[pscustomobject]@{
			Word=“mender";
			IPA="ˈmɛndər"
		},
		[pscustomobject]@{
			Word=“miner";
			IPA="ˈmaɪnər"
		},
		[pscustomobject]@{
			Word=“noggin";
			IPA="ˈnɑɡɪn"
		},
		[pscustomobject]@{
			Word=“officer";
			IPA="ˈɔfəsər"
		},
		[pscustomobject]@{
			Word=“planner";
			IPA="ˈplænər"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“putter";
			IPA="ˈpʌtər"
		},
		[pscustomobject]@{
			Word=“reader";
			IPA="ˈridər"
		},
		[pscustomobject]@{
			Word=“roller";
			IPA="ˈroʊlər"
		},
		[pscustomobject]@{
			Word=“rooter";
			IPA="ˈrutər"
		},
		[pscustomobject]@{
			Word=“scamp";
			IPA="skæmp"
		},
		[pscustomobject]@{
			Word=“scooper";
			IPA="ˈskupər"
		},
		[pscustomobject]@{
			Word=“sealer";
			IPA="ˈsilər"
		},
		[pscustomobject]@{
			Word=“seeker";
			IPA="ˈsikər"
		},
		[pscustomobject]@{
			Word=“setter";
			IPA="ˈsɛtər"
		},
		[pscustomobject]@{
			Word=“shaper";
			IPA="ˈʃeɪpər"
		},
		[pscustomobject]@{
			Word=“sharer";
			IPA="ˈʃɛrər"
		},
		[pscustomobject]@{
			Word=“shiner";
			IPA="ˈʃaɪnər"
		},
		[pscustomobject]@{
			Word=“signer";
			IPA="ˈsaɪnər"
		},
		[pscustomobject]@{
			Word=“sinker";
			IPA="ˈsɪŋkər"
		},
		[pscustomobject]@{
			Word=“snacker";
			IPA="ˈsnækər"
		},
		[pscustomobject]@{
			Word=“snatcher";
			IPA="ˈsnæʧər"
		},
		[pscustomobject]@{
			Word=“snipper";
			IPA="ˈsnɪpər"
		},
		[pscustomobject]@{
			Word=“speaker";
			IPA="ˈspikər"
		},
		[pscustomobject]@{
			Word=“spinner";
			IPA="ˈspɪnər"
		},
		[pscustomobject]@{
			Word=“stamper";
			IPA="ˈstæmpər"
		},
		[pscustomobject]@{
			Word=“stopper";
			IPA="ˈstɑpər"
		},
		[pscustomobject]@{
			Word=“sweeper";
			IPA="ˈswipər"
		},
		[pscustomobject]@{
			Word=“taster";
			IPA="ˈteɪstər"
		},
		[pscustomobject]@{
			Word=“teacher";
			IPA="ˈtiʧər"
		},
		[pscustomobject]@{
			Word=“teller";
			IPA="ˈtɛlər"
		},
		[pscustomobject]@{
			Word=“tender";
			IPA="ˈtɛndər"
		},
		[pscustomobject]@{
			Word=“thrower";
			IPA="ˈθroʊər"
		},
		[pscustomobject]@{
			Word=“thumper";
			IPA="ˈθʌmpər"
		},
		[pscustomobject]@{
			Word=“ticker";
			IPA="ˈtɪkər"
		},
		[pscustomobject]@{
			Word=“tinker";
			IPA="ˈtɪŋkər"
		},
		[pscustomobject]@{
			Word=“tricker";
			IPA="ˈtrɪkər"
		},
		[pscustomobject]@{
			Word=“tucker";
			IPA="ˈtʌkər"
		},
		[pscustomobject]@{
			Word=“twitcher";
			IPA="ˈtwɪʧər"
		},
		[pscustomobject]@{
			Word=“watcher";
			IPA="ˈwɑʧər"
		},
		[pscustomobject]@{
			Word=“winder";
			IPA="ˈwaɪndər"
		},
		[pscustomobject]@{
			Word=“witcher";
			IPA="ˈwɪʧər"
		},
		[pscustomobject]@{
			Word=“worker";
			IPA="ˈwɜrkər"
		},
		[pscustomobject]@{
			Word=“writer";
			IPA="ˈraɪtər"
		}
)

$RockAdjectiveObjects = @(
    	[pscustomobject]@{
			Word=“best";
			IPA="bɛst"
		},
		[pscustomobject]@{
			Word=“brass";
			IPA="bræs"
		},
		[pscustomobject]@{
			Word=“bright";
			IPA="braɪt"
		},
		[pscustomobject]@{
			Word=“candy";
			IPA="ˈkændi"
		},
		[pscustomobject]@{
			Word=“cheery";
			IPA="ˈʧɪri"
		},
		[pscustomobject]@{
			Word=“chitty";
			IPA="ˈʧɪti"
		},
		[pscustomobject]@{
			Word=“chrome";
			IPA="kroʊm"
		},
		[pscustomobject]@{
			Word=“clean";
			IPA="klin"
		},
		[pscustomobject]@{
			Word=“clever";
			IPA="ˈklɛvər"
		},
		[pscustomobject]@{
			Word=“cold";
			IPA="koʊld"
		},
		[pscustomobject]@{
			Word=“copper";
			IPA="ˈkɑpər"
		},
		[pscustomobject]@{
			Word=“crackle";
			IPA="ˈkrækəl"
		},
		[pscustomobject]@{
			Word=“crafty";
			IPA="ˈkræfti"
		},
		[pscustomobject]@{
			Word=“crumb";
			IPA="krʌm"
		},
		[pscustomobject]@{
			Word=“deep";
			IPA="dip"
		},
		[pscustomobject]@{
			Word=“dizzy";
			IPA="ˈdɪzi"
		},
		[pscustomobject]@{
			Word=“double";
			IPA="ˈdʌbəl"
		},
		[pscustomobject]@{
			Word=“drive";
			IPA="draɪv"
		},
		[pscustomobject]@{
			Word=“dusty";
			IPA="ˈdʌsti"
		},
		[pscustomobject]@{
			Word=“fair";
			IPA="fɛr"
		},
		[pscustomobject]@{
			Word=“fault";
			IPA="fɔlt"
		},
		[pscustomobject]@{
			Word=“fraggle";
			IPA="fɹæɡɫ̩"
		},
		[pscustomobject]@{
			Word=“frolic";
			IPA="ˈfrɑlɪk"
		},
		[pscustomobject]@{
			Word=“funny";
			IPA="ˈfʌni"
		},
		[pscustomobject]@{
			Word=“gem";
			IPA="ʤɛm"
		},
		[pscustomobject]@{
			Word=“gold";
			IPA="ɡoʊld"
		},
		[pscustomobject]@{
			Word=“good";
			IPA="ɡʊd"
		},
		[pscustomobject]@{
			Word=“grumble";
			IPA="ˈɡrʌmbəl"
		},
		[pscustomobject]@{
			Word=“happy";
			IPA="ˈhæpi"
		},
		[pscustomobject]@{
			Word=“hard";
			IPA="hɑrd"
		},
		[pscustomobject]@{
			Word=“high";
			IPA="haɪ"
		},
		[pscustomobject]@{
			Word=“inky";
			IPA="ˈɪŋki"
		},
		[pscustomobject]@{
			Word=“itchy";
			IPA="ˈɪʧi"
		},
		[pscustomobject]@{
			Word=“knotty";
			IPA="ˈnɑti"
		},
		[pscustomobject]@{
			Word=“long";
			IPA="lɔŋ"
		},
		[pscustomobject]@{
			Word=“lost";
			IPA="lɔst"
		},
		[pscustomobject]@{
			Word=“loud";
			IPA="laʊd"
		},
		[pscustomobject]@{
			Word=“low";
			IPA="loʊ"
		},
		[pscustomobject]@{
			Word=“magic";
			IPA="ˈmæʤɪk"
		},
		[pscustomobject]@{
			Word=“munch";
			IPA="mʌnʧ"
		},
		[pscustomobject]@{
			Word=“naughty";
			IPA="ˈnɔti"
		},
		[pscustomobject]@{
			Word=“next";
			IPA="nɛkst"
		},
		[pscustomobject]@{
			Word=“noble";
			IPA="ˈnoʊbəl"
		},
		[pscustomobject]@{
			Word=“odd";
			IPA="ɑd"
		},
		[pscustomobject]@{
			Word=“old";
			IPA="oʊld"
		},
		[pscustomobject]@{
			Word=“over";
			IPA="ˈoʊvər"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“power";
			IPA="ˈpaʊər"
		},
		[pscustomobject]@{
			Word=“quartz";
			IPA="kwɔrts"
		},
		[pscustomobject]@{
			Word=“quick";
			IPA="kwɪk"
		},
		[pscustomobject]@{
			Word=“rusty";
			IPA="ˈrʌsti"
		},
		[pscustomobject]@{
			Word=“safe";
			IPA="seɪf"
		},
		[pscustomobject]@{
			Word=“short";
			IPA="ʃɔrt"
		},
		[pscustomobject]@{
			Word=“silver";
			IPA="ˈsɪlvər"
		},
		[pscustomobject]@{
			Word=“sledge";
			IPA="slɛʤ"
		},
		[pscustomobject]@{
			Word=“sly";
			IPA="slaɪ"
		},
		[pscustomobject]@{
			Word=“soft";
			IPA="sɔft"
		},
		[pscustomobject]@{
			Word=“soot";
			IPA="sʊt"
		},
		[pscustomobject]@{
			Word=“spore";
			IPA="spɔr"
		},
		[pscustomobject]@{
			Word=“steady";
			IPA="ˈstɛdi"
		},
		[pscustomobject]@{
			Word=“strict";
			IPA="strɪkt"
		},
		[pscustomobject]@{
			Word=“sweet";
			IPA="swit"
		},
		[pscustomobject]@{
			Word=“tender";
			IPA="ˈtɛndər"
		},
		[pscustomobject]@{
			Word=“tinker";
			IPA="ˈtɪŋkər"
		},
		[pscustomobject]@{
			Word=“tiny";
			IPA="ˈtaɪni"
		},
		[pscustomobject]@{
			Word=“top";
			IPA="tɑp"
		},
		[pscustomobject]@{
			Word=“trick";
			IPA="trɪk"
		},
		[pscustomobject]@{
			Word=“tricksy";
			IPA="tɹɪksi"
		},
		[pscustomobject]@{
			Word=“twitchy";
			IPA="ˈtwɪt͡ʃi"
		},
		[pscustomobject]@{
			Word=“under";
			IPA="ˈʌndər"
		},
		[pscustomobject]@{
			Word=“twinkle";
			IPA="ˈtwɪŋkəl"
		},
		[pscustomobject]@{
			Word=“warm";
			IPA="wɔrm"
		},
		[pscustomobject]@{
			Word=“wee";
			IPA="wi"
		},
		[pscustomobject]@{
			Word=“witty";
			IPA="ˈwɪti"
		},
		[pscustomobject]@{
			Word=“wonder";
			IPA="ˈwʌndər"
		},
		[pscustomobject]@{
			Word=“work";
			IPA="wɜrk"
		}
    )

$RockRhymingSounds = @("eɪ","əl","æ","ɔ","ɪr","ɛl","li","ɛn","u","təl","di","ʌ","ən","vər","aɪ","ɪ","ɑ","oʊ","æf","kəl","aɪn","ʌk","oʊ","ʊər","ɪŋk","æk","ɑk","ɔr","ɑp","ɔŋ","ɪŋ","ri","ɪʧ","ɛd","ʌm","ɪk")

#region Dynamically populate rhyme sounds
$RockRhymingSoundsDynamic = @()

foreach($Word in $RockNounObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($RockRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$RockRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $RockAgentObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($RockRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$RockRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $RockAdjectiveObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($RockRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$RockRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}
#endregion

$RockNounPhoneticUniques = $RockNounObjects.IPA | %{"$(if($_[0] -eq "ˈ"){$_[1]}else{$_[0]})"} | Sort-Object | Get-Unique
$RockAgentPhoneticUniques = $RockAgentObjects.IPA | %{"$(if($_[0] -eq "ˈ"){$_[1]}else{$_[0]})"} | Sort-Object | Get-Unique
$RockAdjectivePhoneticUniques = $RockAdjectiveObjects.IPA | %{"$(if($_[0] -eq "ˈ"){$_[1]}else{$_[0]})"} | Sort-Object | Get-Unique 

########
#Forest#
########

$ForestNounObjects =  @(

    	[pscustomobject]@{
			Word=“aloe";
			IPA="ˈæˌloʊ"
		},
		[pscustomobject]@{
			Word=“acorn";
			IPA="ˈeɪkɔrn"
		},
		[pscustomobject]@{
			Word=“alder";
			IPA="ˈɔldər"
		},
		[pscustomobject]@{
			Word=“apple";
			IPA="ˈæpəl"
		},
		[pscustomobject]@{
			Word=“autumn";
			IPA="ˈɔtəm"
		},
		[pscustomobject]@{
			Word=“barb";
			IPA="bɑrb"
		},
		[pscustomobject]@{
			Word=“bark";
			IPA="bɑrk"
		},
		[pscustomobject]@{
			Word=“basket";
			IPA="ˈbæskət"
		},
		[pscustomobject]@{
			Word=“bean";
			IPA="bin"
		},
		[pscustomobject]@{
			Word=“beard";
			IPA="bɪrd"
		},
		[pscustomobject]@{
			Word=“bed";
			IPA="bɛd"
		},
		[pscustomobject]@{
			Word=“bee";
			IPA="bi"
		},
		[pscustomobject]@{
			Word=“beet";
			IPA="bit"
		},
		[pscustomobject]@{
			Word=“bell";
			IPA="bɛl"
		},
		[pscustomobject]@{
			Word=“belly";
			IPA="ˈbɛli"
		},
		[pscustomobject]@{
			Word=“berry";
			IPA="ˈbɛri"
		},
		[pscustomobject]@{
			Word=“birch";
			IPA="bɜrʧ"
		},
		[pscustomobject]@{
			Word=“blanket";
			IPA="ˈblæŋkɪt"
		},
		[pscustomobject]@{
			Word=“bloom";
			IPA="blum"
		},
		[pscustomobject]@{
			Word=“bobbin";
			IPA="ˈbɑbən"
		},
		[pscustomobject]@{
			Word=“bottle";
			IPA="ˈbɑtəl"
		},
		[pscustomobject]@{
			Word=“bough";
			IPA="baʊ"
		},
		[pscustomobject]@{
			Word=“breeze";
			IPA="briz"
		},
		[pscustomobject]@{
			Word=“bubble";
			IPA="ˈbʌbəl"
		},
		[pscustomobject]@{
			Word=“buckle";
			IPA="ˈbʌkəl"
		},
		[pscustomobject]@{
			Word=“bud";
			IPA="bʌd"
		},
		[pscustomobject]@{
			Word=“buddy";
			IPA="ˈbʌdi"
		},
		[pscustomobject]@{
			Word=“bug";
			IPA="bʌɡ"
		},
		[pscustomobject]@{
			Word=“bulb";
			IPA="bʌlb"
		},
		[pscustomobject]@{
			Word=“bur";
			IPA="bɜr"
		},
		[pscustomobject]@{
			Word=“biscuit";
			IPA="ˈbɪskət"
		},
		[pscustomobject]@{
			Word=“bush";
			IPA="bʊʃ"
		},
		[pscustomobject]@{
			Word=“butter";
			IPA="ˈbʌtər"
		},
		[pscustomobject]@{
			Word=“button";
			IPA="ˈbʌtən"
		},
		[pscustomobject]@{
			Word=“candle";
			IPA="ˈkændəl"
		},
		[pscustomobject]@{
			Word=“candy";
			IPA="ˈkændi"
		},
		[pscustomobject]@{
			Word=“cane";
			IPA="keɪn"
		},
		[pscustomobject]@{
			Word=“cap";
			IPA="kæp"
		},
		[pscustomobject]@{
			Word=“cedar";
			IPA="ˈsidər"
		},
		[pscustomobject]@{
			Word=“cherry";
			IPA="ˈʧɛri"
		},
        [pscustomobject]@{
			Word=“chive";
			IPA="t͡ʃaɪv"
		},
		[pscustomobject]@{
			Word=“cider";
			IPA="ˈsaɪdər"
		},
		[pscustomobject]@{
			Word=“circle";
			IPA="ˈsɜrkəl"
		},
		[pscustomobject]@{
			Word=“cloud";
			IPA="klaʊd"
		},
		[pscustomobject]@{
			Word=“clover";
			IPA="ˈkloʊvər"
		},
		[pscustomobject]@{
			Word=“comb";
			IPA="koʊm"
		},
		[pscustomobject]@{
			Word=“conker";
			IPA="ˈkɑŋkər"
		},
		[pscustomobject]@{
			Word=“craft";
			IPA="kræft"
		},
		[pscustomobject]@{
			Word=“cream";
			IPA="krim"
		},
		[pscustomobject]@{
			Word=“critter";
			IPA="ˈkrɪtər"
		},
		[pscustomobject]@{
			Word=“crumb";
			IPA="krʌm"
		},
		[pscustomobject]@{
			Word=“crystal";
			IPA="ˈkrɪstəl"
		},
		[pscustomobject]@{
			Word=“cup";
			IPA="kʌp"
		},
		[pscustomobject]@{
			Word=“day";
			IPA="deɪ"
		},
		[pscustomobject]@{
			Word=“daze";
			IPA="deɪz"
		},
		[pscustomobject]@{
			Word=“dingle";
			IPA="ˈdɪŋɡəl"
		},
		[pscustomobject]@{
			Word=“dew";
			IPA="du"
		},
		[pscustomobject]@{
			Word=“dill";
			IPA="dɪl"
		},
		[pscustomobject]@{
			Word=“dream";
			IPA="drim"
		},
		[pscustomobject]@{
			Word=“drip";
			IPA="drɪp"
		},
		[pscustomobject]@{
			Word=“dumpling";
			IPA="ˈdʌmplɪŋ"
		},
		[pscustomobject]@{
			Word=“dusk";
			IPA="dʌsk"
		},
		[pscustomobject]@{
			Word=“dwale";
			IPA="dweɪl"
		},
		[pscustomobject]@{
			Word=“earth";
			IPA="ɜrθ"
		},
		[pscustomobject]@{
			Word=“egg";
			IPA="ɛɡ"
		},
		[pscustomobject]@{
			Word=“elder";
			IPA="ˈɛldər"
		},
		[pscustomobject]@{
			Word=“elm";
			IPA="ɛlm"
		},
		[pscustomobject]@{
			Word=“fern";
			IPA="fɜrn"
		},
		[pscustomobject]@{
			Word=“flip";
			IPA="flɪp"
		},
		[pscustomobject]@{
			Word=“flower";
			IPA="ˈflaʊər"
		},
		[pscustomobject]@{
			Word=“field";
			IPA="fild"
		},
		[pscustomobject]@{
			Word=“fig";
			IPA="fɪɡ"
		},
		[pscustomobject]@{
			Word=“finger";
			IPA="ˈfɪŋɡər"
		},
		[pscustomobject]@{
			Word=“fir";
			IPA="fɜr"
		},
		[pscustomobject]@{
			Word=“fizzle";
			IPA="ˈfɪzəl"
		},
		[pscustomobject]@{
			Word=“forest";
			IPA="ˈfɔrəst"
		},
		[pscustomobject]@{
			Word=“fork";
			IPA="fɔrk"
		},
		[pscustomobject]@{
			Word=“fruit";
			IPA="frut"
		},
		[pscustomobject]@{
			Word=“fumble";
			IPA="ˈfʌmbəl"
		},
		[pscustomobject]@{
			Word=“fungus";
			IPA="ˈfʌŋɡəs"
		},
		[pscustomobject]@{
			Word=“game";
			IPA="ɡeɪm"
		},
		[pscustomobject]@{
			Word=“garden";
			IPA="ˈɡɑrdən"
		},
		[pscustomobject]@{
			Word=“garland";
			IPA="ˈɡɑrlənd"
		},
		[pscustomobject]@{
			Word=“garlic";
			IPA="ˈɡɑrlɪk"
		},
		[pscustomobject]@{
			Word=“germ";
			IPA="ʤɜrm"
		},
		[pscustomobject]@{
			Word=“ginger";
			IPA="ˈʤɪnʤər"
		},
		[pscustomobject]@{
			Word=“glade";
			IPA="ɡleɪd"
		},
		[pscustomobject]@{
			Word=“glove";
			IPA="ɡlʌv"
		},
		[pscustomobject]@{
			Word=“grass";
			IPA="ɡræs"
		},
		[pscustomobject]@{
			Word=“grub";
			IPA="ɡrʌb"
		},
		[pscustomobject]@{
			Word=“harvest";
			IPA="ˈhɑrvəst"
		},
		[pscustomobject]@{
			Word=“hazel";
			IPA="ˈheɪzəl"
		},
		[pscustomobject]@{
			Word=“hearth";
			IPA="hɑrθ"
		},
		[pscustomobject]@{
			Word=“hedge";
			IPA="hɛʤ"
		},
		[pscustomobject]@{
			Word=“hemlock";
			IPA="ˈhɛmˌlɑk"
		},
		[pscustomobject]@{
			Word=“hive";
			IPA="haɪv"
		},
		[pscustomobject]@{
			Word=“hollow";
			IPA="ˈhɑloʊ"
		},
		[pscustomobject]@{
			Word=“holly";
			IPA="ˈhɑli"
		},
		[pscustomobject]@{
			Word=“home";
			IPA="hoʊm"
		},
		[pscustomobject]@{
			Word=“honey";
			IPA="ˈhʌni"
		},
		[pscustomobject]@{
			Word=“horn";
			IPA="hɔrn"
		},
		[pscustomobject]@{
			Word=“hunt";
			IPA="hʌnt"
		},
		[pscustomobject]@{
			Word=“iris";
			IPA="ˈaɪrɪs"
		},
		[pscustomobject]@{
			Word=“ivy";
			IPA="ˈaɪvi"
		},
		[pscustomobject]@{
			Word=“jam";
			IPA="ʤæm"
		},
		[pscustomobject]@{
			Word=“land";
			IPA="lænd"
		},
		[pscustomobject]@{
			Word=“leaf";
			IPA="lif"
		},
		[pscustomobject]@{
			Word=“leek";
			IPA="lik"
		},
		[pscustomobject]@{
			Word=“light";
			IPA="laɪt"
		},
		[pscustomobject]@{
			Word=“lilly";
			IPA="ˈlɪli"
		},
		[pscustomobject]@{
			Word=“litter";
			IPA="ˈlɪtər"
		},
		[pscustomobject]@{
			Word=“lore";
			IPA="lɔr"
		},
		[pscustomobject]@{
			Word=“magic";
			IPA="ˈmæʤɪk"
		},
		[pscustomobject]@{
			Word=“maple";
			IPA="ˈmeɪpəl"
		},
		[pscustomobject]@{
			Word=“marsh";
			IPA="mɑrʃ"
		},
		[pscustomobject]@{
			Word=“meadow";
			IPA="ˈmɛˌdoʊ"
		},
		[pscustomobject]@{
			Word=“melon";
			IPA="ˈmɛlən"
		},
		[pscustomobject]@{
			Word=“milk";
			IPA="mɪlk"
		},
		[pscustomobject]@{
			Word=“mint";
			IPA="mɪnt"
		},
		[pscustomobject]@{
			Word=“moon";
			IPA="mun"
		},
		[pscustomobject]@{
			Word=“morning";
			IPA="ˈmɔrnɪŋ"
		},
		[pscustomobject]@{
			Word=“moss";
			IPA="mɔs"
		},
		[pscustomobject]@{
			Word=“mud";
			IPA="mʌd"
		},
		[pscustomobject]@{
			Word=“muffin";
			IPA="ˈmʌfən"
		},
		[pscustomobject]@{
			Word=“mushroom";
			IPA="ˈmʌʃrum"
		},
		[pscustomobject]@{
			Word=“nap";
			IPA="næp"
		},
		[pscustomobject]@{
			Word=“nature";
			IPA="ˈneɪʧər"
		},
		[pscustomobject]@{
			Word=“nectar";
			IPA="ˈnɛktər"
		},
		[pscustomobject]@{
			Word=“needle";
			IPA="ˈnidəl"
		},
		[pscustomobject]@{
			Word=“nest";
			IPA="nɛst"
		},
		[pscustomobject]@{
			Word=“nettle";
			IPA="ˈnɛtəl"
		},
		[pscustomobject]@{
			Word=“night";
			IPA="naɪt"
		},
		[pscustomobject]@{
			Word=“nubbin";
			IPA="ˈnʌbɪn"
		},
		[pscustomobject]@{
			Word=“nut";
			IPA="nʌt"
		},
		[pscustomobject]@{
			Word=“oak";
			IPA="oʊk"
		},
		[pscustomobject]@{
			Word=“oath";
			IPA="oʊθ"
		},
		[pscustomobject]@{
			Word=“onion";
			IPA="ˈʌnjən"
		},
		[pscustomobject]@{
			Word=“orchid";
			IPA="ˈɔrkəd"
		},
		[pscustomobject]@{
			Word=“paddy";
			IPA="ˈpædi"
		},
		[pscustomobject]@{
			Word=“pansy";
			IPA="ˈpænzi"
		},
		[pscustomobject]@{
			Word=“parsley";
			IPA="ˈpɑrsli"
		},
		[pscustomobject]@{
			Word=“parsnip";
			IPA="ˈpɑɹ.snɪp"
		},
		[pscustomobject]@{
			Word=“patch";
			IPA="pæʧ"
		},
		[pscustomobject]@{
			Word=“path";
			IPA="pæθ"
		},
		[pscustomobject]@{
			Word=“pea";
			IPA="pi"
		},
		[pscustomobject]@{
			Word=“peach";
			IPA="piʧ"
		},
		[pscustomobject]@{
			Word=“pepper";
			IPA="ˈpɛpər"
		},
		[pscustomobject]@{
			Word=“petal";
			IPA="ˈpɛtəl"
		},
		[pscustomobject]@{
			Word=“pillow";
			IPA="ˈpɪloʊ"
		},
		[pscustomobject]@{
			Word=“pine";
			IPA="paɪn"
		},
		[pscustomobject]@{
			Word=“pinky";
			IPA="ˈpɪŋki"
		},
		[pscustomobject]@{
			Word=“pipe";
			IPA="paɪp"
		},
		[pscustomobject]@{
			Word=“plum";
			IPA="plʌm"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“pond";
			IPA="pɑnd"
		},
		[pscustomobject]@{
			Word=“poppy";
			IPA="ˈpɑpi"
		},
		[pscustomobject]@{
			Word=“pot";
			IPA="pɑt"
		},
		[pscustomobject]@{
			Word=“prank";
			IPA="præŋk"
		},
		[pscustomobject]@{
			Word=“promise";
			IPA="ˈprɑməs"
		},
		[pscustomobject]@{
			Word=“prune";
			IPA="prun"
		},
		[pscustomobject]@{
			Word=“puddle";
			IPA="ˈpʌdəl"
		},
		[pscustomobject]@{
			Word=“puff";
			IPA="pʌf"
		},
		[pscustomobject]@{
			Word=“pumpkin";
			IPA="ˈpʌmpkɪn"
		},
		[pscustomobject]@{
			Word=“rain";
			IPA="reɪn"
		},
		[pscustomobject]@{
			Word=“rascal";
			IPA="ˈræskəl"
		},
		[pscustomobject]@{
			Word=“root";
			IPA="rut"
		},
		[pscustomobject]@{
			Word=“rose";
			IPA="roʊz"
		},
		[pscustomobject]@{
			Word=“sap";
			IPA="sæp"
		},
		[pscustomobject]@{
			Word=“scuttle";
			IPA="ˈskʌtəl"
		},
		[pscustomobject]@{
			Word=“seed";
			IPA="sid"
		},
		[pscustomobject]@{
			Word=“shade";
			IPA="ʃeɪd"
		},
		[pscustomobject]@{
			Word=“shoe";
			IPA="ʃu"
		},
		[pscustomobject]@{
			Word=“shoot";
			IPA="ʃut"
		},
		[pscustomobject]@{
			Word=“shroom";
			IPA="ʃɹuːm"
		},
		[pscustomobject]@{
			Word=“shrub";
			IPA="ʃrʌb"
		},
		[pscustomobject]@{
			Word=“sky";
			IPA="skaɪ"
		},
		[pscustomobject]@{
			Word=“slug";
			IPA="slʌɡ"
		},
		[pscustomobject]@{
			Word=“snail";
			IPA="sneɪl"
		},
		[pscustomobject]@{
			Word=“spice";
			IPA="spaɪs"
		},
		[pscustomobject]@{
			Word=“spoon";
			IPA="spun"
		},
		[pscustomobject]@{
			Word=“snack";
			IPA="snæk"
		},
		[pscustomobject]@{
			Word=“song";
			IPA="sɔŋ"
		},
		[pscustomobject]@{
			Word=“soup";
			IPA="sup"
		},
		[pscustomobject]@{
			Word=“spell";
			IPA="spɛl"
		},
		[pscustomobject]@{
			Word=“splinter";
			IPA="ˈsplɪntər"
		},
		[pscustomobject]@{
			Word=“spore";
			IPA="spɔr"
		},
		[pscustomobject]@{
			Word=“song";
			IPA="sɔŋ"
		},
		[pscustomobject]@{
			Word=“sprig";
			IPA="spɹɪɡ"
		},
		[pscustomobject]@{
			Word=“spring";
			IPA="sprɪŋ"
		},
		[pscustomobject]@{
			Word=“spud";
			IPA="spʌd"
		},
		[pscustomobject]@{
			Word=“spruce";
			IPA="sprus"
		},
		[pscustomobject]@{
			Word=“spunk";
			IPA="spʌŋk"
		},
		[pscustomobject]@{
			Word=“stem";
			IPA="stɛm"
		},
		[pscustomobject]@{
			Word=“stone";
			IPA="stoʊn"
		},
		[pscustomobject]@{
			Word=“stew";
			IPA="stu"
		},
		[pscustomobject]@{
			Word=“story";
			IPA="ˈstɔri"
		},
		[pscustomobject]@{
			Word=“sugar";
			IPA="ˈʃʊɡər"
		},
		[pscustomobject]@{
			Word=“summer";
			IPA="ˈsʌmər"
		},
		[pscustomobject]@{
			Word=“sun";
			IPA="sʌn"
		},
		[pscustomobject]@{
			Word=“star";
			IPA="stɑr"
		},
		[pscustomobject]@{
			Word=“stick";
			IPA="stɪk"
		},
		[pscustomobject]@{
			Word=“stream";
			IPA="strim"
		},
		[pscustomobject]@{
			Word=“stump";
			IPA="stʌmp"
		},
		[pscustomobject]@{
			Word=“syrup";
			IPA="ˈsɪrəp"
		},
		[pscustomobject]@{
			Word=“tater";
			IPA="ˈteɪtər"
		},
		[pscustomobject]@{
			Word=“tea";
			IPA="ti"
		},
		[pscustomobject]@{
			Word=“thimble";
			IPA="ˈθɪmbəl"
		},
		[pscustomobject]@{
			Word=“thistle";
			IPA="ˈθɪsəl"
		},
		[pscustomobject]@{
			Word=“thorn";
			IPA="θɔrn"
		},
		[pscustomobject]@{
			Word=“thread";
			IPA="θrɛd"
		},
		[pscustomobject]@{
			Word=“timber";
			IPA="ˈtɪmbər"
		},
		[pscustomobject]@{
			Word=“tonic";
			IPA="ˈtɑnɪk"
		},
		[pscustomobject]@{
			Word=“truffle";
			IPA="ˈtrʌfəl"
		},
		[pscustomobject]@{
			Word=“trunk";
			IPA="trʌŋk"
		},
		[pscustomobject]@{
			Word=“thumb";
			IPA="θʌm"
		},
		[pscustomobject]@{
			Word=“toe";
			IPA="toʊ"
		},
		[pscustomobject]@{
			Word=“tongue";
			IPA="tʌŋ"
		},
		[pscustomobject]@{
			Word=“tooth";
			IPA="tuθ"
		},
		[pscustomobject]@{
			Word=“tree";
			IPA="tri"
		},
		[pscustomobject]@{
			Word=“tuft";
			IPA="tʌft"
		},
		[pscustomobject]@{
			Word=“tulip";
			IPA="ˈtuləp"
		},
		[pscustomobject]@{
			Word=“turnip";
			IPA="ˈtɜrnəp"
		},
		[pscustomobject]@{
			Word=“twig";
			IPA="twɪɡ"
		},
		[pscustomobject]@{
			Word=“vision";
			IPA="ˈvɪʒən"
		},
		[pscustomobject]@{
			Word=“waffle";
			IPA="ˈwɑfəl"
		},
		[pscustomobject]@{
			Word=“wall";
			IPA="wɔl"
		},
		[pscustomobject]@{
			Word=“water";
			IPA="ˈwɔtər"
		},
		[pscustomobject]@{
			Word=“wax";
			IPA="wæks"
		},
		[pscustomobject]@{
			Word=“wind";
			IPA="wɪnd"
		},
		[pscustomobject]@{
			Word=“wit";
			IPA="wɪt"
		},
		[pscustomobject]@{
			Word=“weed";
			IPA="wid"
		},
		[pscustomobject]@{
			Word=“well";
			IPA="wɛl"
		},
		[pscustomobject]@{
			Word=“whistle";
			IPA="ˈwɪsəl"
		},
		[pscustomobject]@{
			Word=“willow";
			IPA="ˈwɪˌloʊ"
		},
		[pscustomobject]@{
			Word=“winter";
			IPA="ˈwɪntər"
		},
		[pscustomobject]@{
			Word=“wish";
			IPA="wɪʃ"
		},
		[pscustomobject]@{
			Word=“wisp";
			IPA="wɪsp"
		},
		[pscustomobject]@{
			Word=“wode";
			IPA="ˈwoːd"
		},
		[pscustomobject]@{
			Word=“wood";
			IPA="wʊd"
		},
		[pscustomobject]@{
			Word=“wort";
			IPA="wɝt"
		},
		[pscustomobject]@{
			Word=“yew";
			IPA="ju"
		}

    )

$ForestAgentObjects = @(
    
    	[pscustomobject]@{
			Word=“belly";
			IPA="ˈbɛli"
		},
		[pscustomobject]@{
			Word=“berry";
			IPA="ˈbɛri"
		},
		[pscustomobject]@{
			Word=“biter";
			IPA="ˈbaɪtər"
		},
		[pscustomobject]@{
			Word=“bits";
			IPA="bɪts"
		},
		[pscustomobject]@{
			Word=“bobber";
			IPA="ˈbɑbər"
		},
		[pscustomobject]@{
			Word=“brush";
			IPA="brʌʃ"
		},
		[pscustomobject]@{
			Word=“buddy";
			IPA="ˈbʌdi"
		},
		[pscustomobject]@{
			Word=“bun";
			IPA="bʌn"
		},
		[pscustomobject]@{
			Word=“buzzer";
			IPA="ˈbʌzər"
		},
		[pscustomobject]@{
			Word=“cake";
			IPA="keɪk"
		},
		[pscustomobject]@{
			Word=“caller";
			IPA="ˈkɔlər"
		},
		[pscustomobject]@{
			Word=“caster";
			IPA="ˈkæstər"
		},
		[pscustomobject]@{
			Word=“catcher";
			IPA="ˈkæʧər"
		},
		[pscustomobject]@{
			Word=“chiller";
			IPA="ˈʧɪlər"
		},
		[pscustomobject]@{
			Word=“chum";
			IPA="ʧʌm"
		},
		[pscustomobject]@{
			Word=“climber";
			IPA="ˈklaɪmər"
		},
		[pscustomobject]@{
			Word=“cooker";
			IPA="ˈkʊkər"
		},
		[pscustomobject]@{
			Word=“crafter";
			IPA="ˈkræftər"
		},
		[pscustomobject]@{
			Word=“critter";
			IPA="ˈkrɪtər"
		},
		[pscustomobject]@{
			Word=“dancer";
			IPA="ˈdænsər"
		},
		[pscustomobject]@{
			Word=“dinger";
			IPA="ˈdɪŋər"
		},
		[pscustomobject]@{
			Word=“dreamer";
			IPA="ˈdrimər"
		},
		[pscustomobject]@{
			Word=“dropper";
			IPA="ˈdrɑpər"
		},
		[pscustomobject]@{
			Word=“fellow";
			IPA="ˈfɛloʊ"
		},
		[pscustomobject]@{
			Word=“field";
			IPA="fild"
		},
		[pscustomobject]@{
			Word=“finder";
			IPA="ˈfaɪndər"
		},
		[pscustomobject]@{
			Word=“fixer";
			IPA="ˈfɪksər"
		},
		[pscustomobject]@{
			Word=“flicker";
			IPA="ˈflɪkər"
		},
		[pscustomobject]@{
			Word=“flitter";
			IPA="ˈflɪtər"
		},
		[pscustomobject]@{
			Word=“flower";
			IPA="ˈflaʊər"
		},
		[pscustomobject]@{
			Word=“friend";
			IPA="frɛnd"
		},
		[pscustomobject]@{
			Word=“friend";
			IPA="frɛnd"
		},
		[pscustomobject]@{
			Word=“friend";
			IPA="frɛnd"
		},
		[pscustomobject]@{
			Word=“gnome";
			IPA="noʊm"
		},
		[pscustomobject]@{
			Word=“giver";
			IPA="ˈɡɪvər"
		},
		[pscustomobject]@{
			Word=“grower";
			IPA="ˈɡroʊər"
		},
		[pscustomobject]@{
			Word=“gum";
			IPA="ɡʌm"
		},
		[pscustomobject]@{
			Word=“heimer";
			IPA="ˈhaɪmər"
		},
		[pscustomobject]@{
			Word=“helmer";
			IPA="ˈhɛlmər"
		},
		[pscustomobject]@{
			Word=“hider";
			IPA="ˈhaɪdər"
		},
		[pscustomobject]@{
			Word=“holder";
			IPA="ˈhoʊldər"
		},
		[pscustomobject]@{
			Word=“home";
			IPA="hoʊm"
		},
		[pscustomobject]@{
			Word=“hopper";
			IPA="ˈhɑpər"
		},
		[pscustomobject]@{
			Word=“hummer";
			IPA="ˈhʌmər"
		},
		[pscustomobject]@{
			Word=“hunter";
			IPA="ˈhʌntər"
		},
		[pscustomobject]@{
			Word=“itcher";
			IPA="ˈɪʧər"
		},
		[pscustomobject]@{
			Word=“jelly";
			IPA="ˈʤɛli"
		},
		[pscustomobject]@{
			Word=“joker";
			IPA="ˈʤoʊkər"
		},
		[pscustomobject]@{
			Word=“juicer";
			IPA="ˈʤusər"
		},
		[pscustomobject]@{
			Word=“keeper";
			IPA="ˈkipər"
		},
		[pscustomobject]@{
			Word=“knickers";
			IPA="ˈnɪkərz"
		},
		[pscustomobject]@{
			Word=“knocker";
			IPA="ˈnɑkər"
		},
		[pscustomobject]@{
			Word=“knot";
			IPA="nɑt"
		},
		[pscustomobject]@{
			Word=“lover";
			IPA="ˈlʌvər"
		},
		[pscustomobject]@{
			Word=“maker";
			IPA="ˈmeɪkər"
		},
		[pscustomobject]@{
			Word=“mallow";
			IPA="ˈmæloʊ"
		},
		[pscustomobject]@{
			Word=“mannin";
			IPA="ˈmanːɪn"
		},
		[pscustomobject]@{
			Word=“mate";
			IPA="meɪt"
		},
		[pscustomobject]@{
			Word=“meister";
			IPA="ˈmaɪstər"
		},
		[pscustomobject]@{
			Word=“mender";
			IPA="ˈmɛndər"
		},
		[pscustomobject]@{
			Word=“meyer";
			IPA="ˈmaɪər"
		},
		[pscustomobject]@{
			Word=“monch";
			IPA="ˈmonʧ"
		},
		[pscustomobject]@{
			Word=“more";
			IPA="mɔr"
		},
		[pscustomobject]@{
			Word=“munch";
			IPA="mʌnʧ"
		},
		[pscustomobject]@{
			Word=“muncher";
			IPA="ˈmʌnʧər"
		},
		[pscustomobject]@{
			Word=“namer";
			IPA="ˈneɪmər"
		},
		[pscustomobject]@{
			Word=“noggin";
			IPA="ˈnɑɡɪn"
		},
		[pscustomobject]@{
			Word=“pants";
			IPA="pænts"
		},
		[pscustomobject]@{
			Word=“picker";
			IPA="ˈpɪkər"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“planter";
			IPA="ˈplæntər"
		},
		[pscustomobject]@{
			Word=“player";
			IPA="ˈpleɪər"
		},
		[pscustomobject]@{
			Word=“plucker";
			IPA="ˈplʌkər"
		},
		[pscustomobject]@{
			Word=“prank";
			IPA="præŋk"
		},
		[pscustomobject]@{
			Word=“puffer";
			IPA="ˈpʌfər"
		},
		[pscustomobject]@{
			Word=“puller";
			IPA="ˈpʊlər"
		},
		[pscustomobject]@{
			Word=“pusher";
			IPA="ˈpʊʃər"
		},
		[pscustomobject]@{
			Word=“putter";
			IPA="ˈpʌtər"
		},
		[pscustomobject]@{
			Word=“patcher";
			IPA="ˈpæʧər"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“ranger";
			IPA="ˈreɪnʤər"
		},
		[pscustomobject]@{
			Word=“rooter";
			IPA="ˈrutər"
		},
		[pscustomobject]@{
			Word=“rump";
			IPA="rʌmp"
		},
		[pscustomobject]@{
			Word=“sage";
			IPA="seɪʤ"
		},
		[pscustomobject]@{
			Word=“scamp";
			IPA="skæmp"
		},
		[pscustomobject]@{
			Word=“scratcher";
			IPA="ˈskræʧər"
		},
		[pscustomobject]@{
			Word=“seeker";
			IPA="ˈsikər"
		},
		[pscustomobject]@{
			Word=“seer";
			IPA="sir"
		},
		[pscustomobject]@{
			Word=“shaper";
			IPA="ˈʃeɪpər"
		},
		[pscustomobject]@{
			Word=“sharer";
			IPA="ˈʃɛrər"
		},
		[pscustomobject]@{
			Word=“sipper";
			IPA="ˈsɪpər"
		},
		[pscustomobject]@{
			Word=“smoker";
			IPA="ˈsmoʊkər"
		},
		[pscustomobject]@{
			Word=“snacker";
			IPA="ˈsnækər"
		},
		[pscustomobject]@{
			Word=“snatcher";
			IPA="ˈsnæʧər"
		},
		[pscustomobject]@{
			Word=“speaker";
			IPA="ˈspikər"
		},
		[pscustomobject]@{
			Word=“splitter";
			IPA="ˈsplɪtər"
		},
		[pscustomobject]@{
			Word=“spinner";
			IPA="ˈspɪnər"
		},
		[pscustomobject]@{
			Word=“stamper";
			IPA="ˈstæmpər"
		},
		[pscustomobject]@{
			Word=“stinger";
			IPA="ˈstɪŋər"
		},
		[pscustomobject]@{
			Word=“stitcher";
			IPA="ˈstɪʧər"
		},
		[pscustomobject]@{
			Word=“stopper";
			IPA="ˈstɑpər"
		},
		[pscustomobject]@{
			Word=“straw";
			IPA="strɔ"
		},
		[pscustomobject]@{
			Word=“supper";
			IPA="ˈsʌpər"
		},
		[pscustomobject]@{
			Word=“taster";
			IPA="ˈteɪstər"
		},
		[pscustomobject]@{
			Word=“teacher";
			IPA="ˈtiʧər"
		},
		[pscustomobject]@{
			Word=“teller";
			IPA="ˈtɛlər"
		},
		[pscustomobject]@{
			Word=“tender";
			IPA="ˈtɛndər"
		},
		[pscustomobject]@{
			Word=“thrower";
			IPA="ˈθroʊər"
		},
		[pscustomobject]@{
			Word=“thumper";
			IPA="ˈθʌmpər"
		},
		[pscustomobject]@{
			Word=“tinker";
			IPA="ˈtɪŋkər"
		},
		[pscustomobject]@{
			Word=“toker";
			IPA="təʊkɚ"
		},
		[pscustomobject]@{
			Word=“tracker";
			IPA="ˈtrækər"
		},
		[pscustomobject]@{
			Word=“trapper";
			IPA="ˈtræpər"
		},
		[pscustomobject]@{
			Word=“tricker";
			IPA="ˈtrɪkər"
		},
		[pscustomobject]@{
			Word=“tucker";
			IPA="ˈtʌkər"
		},
		[pscustomobject]@{
			Word=“tumbler";
			IPA="ˈtʌmblər"
		},
		[pscustomobject]@{
			Word=“tummy";
			IPA="ˈtʌmi"
		},
		[pscustomobject]@{
			Word=“twitcher";
			IPA="ˈtwɪʧər"
		},
		[pscustomobject]@{
			Word=“vine";
			IPA="vaɪn"
		},
		[pscustomobject]@{
			Word=“wander";
			IPA="ˈwɑndər"
		},
		[pscustomobject]@{
			Word=“watcher";
			IPA="ˈwɑʧər"
		},
		[pscustomobject]@{
			Word=“weaver";
			IPA="ˈwivər"
		},
		[pscustomobject]@{
			Word=“weeder";
			IPA="ˈwidər"
		},
		[pscustomobject]@{
			Word=“wicker";
			IPA="ˈwɪkər"
		},
		[pscustomobject]@{
			Word=“wisher";
			IPA="ˈwɪʃər"
		},
		[pscustomobject]@{
			Word=“witcher";
			IPA="ˈwɪʧər"
		},
		[pscustomobject]@{
			Word=“worker";
			IPA="ˈwɜrkər"
		}
    
    )

$ForestAdjectiveObjects = @(

    	[pscustomobject]@{
			Word=“bright";
			IPA="braɪt"
		},
		[pscustomobject]@{
			Word=“butter";
			IPA="ˈbʌtər"
		},
		[pscustomobject]@{
			Word=“calm";
			IPA="kɑm"
		},
		[pscustomobject]@{
			Word=“candy";
			IPA="ˈkændi"
		},
		[pscustomobject]@{
			Word=“cheery";
			IPA="ˈʧɪri"
		},
		[pscustomobject]@{
			Word=“chortle";
			IPA="ˈʧɔrtəl"
		},
		[pscustomobject]@{
			Word=“clean";
			IPA="klin"
		},
		[pscustomobject]@{
			Word=“clever";
			IPA="ˈklɛvər"
		},
		[pscustomobject]@{
			Word=“cold";
			IPA="koʊld"
		},
		[pscustomobject]@{
			Word=“cozy";
			IPA="ˈkoʊzi"
		},
		[pscustomobject]@{
			Word=“crafty";
			IPA="ˈkræfti"
		},
		[pscustomobject]@{
			Word=“crumb";
			IPA="krʌm"
		},
		[pscustomobject]@{
			Word=“dizzy";
			IPA="ˈdɪzi"
		},
		[pscustomobject]@{
			Word=“double";
			IPA="ˈdʌbəl"
		},
		[pscustomobject]@{
			Word=“early";
			IPA="ˈɜrli"
		},
		[pscustomobject]@{
			Word=“easy";
			IPA="ˈizi"
		},
		[pscustomobject]@{
			Word=“fair";
			IPA="fɛr"
		},
		[pscustomobject]@{
			Word=“fey";
			IPA="feɪ"
		},
		[pscustomobject]@{
			Word=“frolic";
			IPA="ˈfrɑlɪk"
		},
		[pscustomobject]@{
			Word=“funny";
			IPA="ˈfʌni"
		},
		[pscustomobject]@{
			Word=“glad";
			IPA="ɡlæd"
		},
		[pscustomobject]@{
			Word=“good";
			IPA="ɡʊd"
		},
		[pscustomobject]@{
			Word=“green";
			IPA="ɡrin"
		},
		[pscustomobject]@{
			Word=“grumble";
			IPA="ˈɡrʌmbəl"
		},
		[pscustomobject]@{
			Word=“half";
			IPA="hæf"
		},
		[pscustomobject]@{
			Word=“happy";
			IPA="ˈhæpi"
		},
		[pscustomobject]@{
			Word=“hard";
			IPA="hɑrd"
		},
		[pscustomobject]@{
			Word=“high";
			IPA="haɪ"
		},
		[pscustomobject]@{
			Word=“humming";
			IPA="ˈhʌmɪŋ"
		},
		[pscustomobject]@{
			Word=“itchy";
			IPA="ˈɪʧi"
		},
		[pscustomobject]@{
			Word=“jelly";
			IPA="ˈʤɛli"
		},
		[pscustomobject]@{
			Word=“lax";
			IPA="læks"
		},
		[pscustomobject]@{
			Word=“long";
			IPA="lɔŋ"
		},
		[pscustomobject]@{
			Word=“lost";
			IPA="lɔst"
		},
		[pscustomobject]@{
			Word=“loud";
			IPA="laʊd"
		},
		[pscustomobject]@{
			Word=“low";
			IPA="loʊ"
		},
		[pscustomobject]@{
			Word=“magic";
			IPA="ˈmæʤɪk"
		},
		[pscustomobject]@{
			Word=“mellow";
			IPA="ˈmɛloʊ"
		},
		[pscustomobject]@{
			Word=“muddy";
			IPA="ˈmʌdi"
		},
		[pscustomobject]@{
			Word=“munch";
			IPA="mʌnʧ"
		},
		[pscustomobject]@{
			Word=“naughty";
			IPA="ˈnɔti"
		},
		[pscustomobject]@{
			Word=“nutty";
			IPA="ˈnʌti"
		},
		[pscustomobject]@{
			Word=“oak";
			IPA="oʊk"
		},
		[pscustomobject]@{
			Word=“odd";
			IPA="ɑd"
		},
		[pscustomobject]@{
			Word=“over";
			IPA="ˈoʊvər"
		},
		[pscustomobject]@{
			Word=“pocket";
			IPA="ˈpɑkət"
		},
		[pscustomobject]@{
			Word=“puff";
			IPA="pʌf"
		},
		[pscustomobject]@{
			Word=“quick";
			IPA="kwɪk"
		},
		[pscustomobject]@{
			Word=“ripe";
			IPA="raɪp"
		},
		[pscustomobject]@{
			Word=“shady";
			IPA="ˈʃeɪdi"
		},
		[pscustomobject]@{
			Word=“short";
			IPA="ʃɔrt"
		},
		[pscustomobject]@{
			Word=“silver";
			IPA="ˈsɪlvər"
		},
		[pscustomobject]@{
			Word=“sly";
			IPA="slaɪ"
		},
		[pscustomobject]@{
			Word=“soft";
			IPA="sɔft"
		},
		[pscustomobject]@{
			Word=“spore";
			IPA="spɔr"
		},
		[pscustomobject]@{
			Word=“steady";
			IPA="ˈstɛdi"
		},
		[pscustomobject]@{
			Word=“stink";
			IPA="stɪŋk"
		},
		[pscustomobject]@{
			Word=“sugar";
			IPA="ˈʃʊɡər"
		},
		[pscustomobject]@{
			Word=“sunny";
			IPA="ˈsʌni"
		},
		[pscustomobject]@{
			Word=“sweet";
			IPA="swit"
		},
		[pscustomobject]@{
			Word=“tender";
			IPA="ˈtɛndər"
		},
		[pscustomobject]@{
			Word=“thunder";
			IPA="ˈθʌndər"
		},
		[pscustomobject]@{
			Word=“tiny";
			IPA="ˈtaɪni"
		},
		[pscustomobject]@{
			Word=“tricksy";
			IPA=""
		},
		[pscustomobject]@{
			Word=“twitchy";
			IPA=""
		},
		[pscustomobject]@{
			Word=“twinkle";
			IPA="ˈtwɪŋkəl"
		},
		[pscustomobject]@{
			Word=“warm";
			IPA="wɔrm"
		},
		[pscustomobject]@{
			Word=“wee";
			IPA="wi"
		},
		[pscustomobject]@{
			Word=“wild";
			IPA="waɪld"
		},
		[pscustomobject]@{
			Word=“witty";
			IPA="ˈwɪti"
		},
		[pscustomobject]@{
			Word=“wonder";
			IPA="ˈwʌndər"
		},
		[pscustomobject]@{
			Word=“wood";
			IPA="wʊd"
		}

)

#region Dynamically populate rhyme sounds
$ForestRhymingSoundsDynamic = @()

foreach($Word in $ForestNounObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($ForestRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$ForestRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $ForestAgentObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($ForestRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$ForestRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $ForestAdjectiveObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($ForestRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$ForestRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}
#endregion

$ForestNounPhoneticUniques = $ForestNounObjects.IPA | %{"$(if($_[0] -eq "ˈ"){$_[1]}else{$_[0]})"} | Sort-Object | Get-Unique
$ForestAgentPhoneticUniques = $ForestAgentObjects.IPA | %{"$(if($_[0] -eq "ˈ"){$_[1]}else{$_[0]})"} | Sort-Object | Get-Unique
$ForestAdjectivePhoneticUniques = $ForestAdjectiveObjects.IPA | %{"$(if($_[0] -eq "ˈ"){$_[1]}else{$_[0]})"} | Sort-Object | Get-Unique

#endregion

<#
$ForestNouns = @("aloe","acorn","alder","apple","autumn","barb","bark","basket","bean","beard","bed","bee","beet","bell","belly","berry","birch","biscuit","blanket","bloom","bobbin","bottle","bough","breeze","bubble","buckle","bud","buddy","bug","bulb","bur","bush","butter","button","candle","candy","cane","cap","cedar","cherry","cider","chive","circle","cloud","clover","comb","conker","craft","cream","critter","crumb","crystal","cup","day","daze","dingle","dew","dill","dream","drip","dumpling","dusk","dwale","earth","egg","elder","elm","fern","flip","flower","field","fig","finger","fir","fizzle","forest","fork","fruit","fumble","fungus","game","garden","garland","garlic","germ","ginger","glade","glove","grass","grub","harvest","hazel","hearth","hedge","hemlock","hive","hollow","holly","home","honey","horn","hunt","iris","ivy","jam","land","leaf","leek","light","lilly","litter","lore","magic","maple","marsh","meadow","melon","milk","mint","moon","morning","moss","mud","muffin","mushroom","nap","nature","nectar","needle","nest","nettle","night","nubbin","nut","oak","oath","onion","orchid","paddy","pansy","parsley","parsnip","patch","path","pea","peach","pepper","petal","pillow","pine","pinky","pipe","plum","pocket","pond","poppy","pot","prank","promise","prune","puddle","puff","pumpkin","rain","rascal","root","rose","sap","scuttle","seed","shade","shoe","shoot","shroom","shrub","sky","slug","snail","spice","spoon","snack","song","soup","spell","splinter","spore","song","sprig","spring","spud","spruce","spunk","stem","stone","stew","story","sugar","summer","sun","star","stick","stream","stump","syrup","tater","tea","thimble","thistle","thorn","thread","timber","tonic","truffle","trunk","thumb","toe","tongue","tooth","tree","tuft","tulip","turnip","twig","vision","waffle","wall","water","wax","wind","wit","weed","well","whistle","willow","winter","wish","wisp","wode","wood","wort","yew")
$ForestAgents = @("belly","berry","biter","bits","bobber","brush","buddy","bun","buzzer","cake","caller","caster","catcher","chiller","chum","climber","cooker","crafter","critter","dancer","dinger","dreamer","dropper","fellow","field","finder","fixer","flicker","flitter","flower","friend","friend","friend","gnome","giver","grower","gum","heimer","helmer","hider","holder","home","hopper","hummer","hunter","itcher","jelly","joker","juicer","keeper","knickers","knocker","knot","lover","maker","mallow","mannin","mate","meister","mender","meyer","monch","more","munch","muncher","namer","noggin","pants","picker","pocket","planter","player","plucker","prank","puffer","puller","pusher","putter","patcher","pocket","ranger","rooter","rump","sage","scamp","scratcher","seeker","seer","shaper","sharer","sipper","smoker","snacker","snatcher","speaker","splitter","spinner","stamper","stinger","stitcher","stopper","straw","supper","taster","teacher","teller","tender","thrower","thumper","tinker","toker","tracker","trapper","tricker","tucker","tumbler","tummy","twitcher","vine","wander","watcher","weaver","weeder","wicker","wisher","witcher","worker")
$ForestAdjectives = @("bright","butter","calm","candy","cheery","chortle","clean","clever","cold","cozy","crafty","crumb","dizzy","double","early","easy","fair","fey","frolic","funny","glad","good","green","grumble","half","happy","hard","high","humming","itchy","jelly","lax","long","lost","loud","low","magic","mellow","muddy","munch","naughty","nutty","oak","odd","over","pocket","puff","quick","ripe","shady","short","silver","sly","soft","spore","steady","stink","sugar","sunny","sweet","tender","thunder","tiny","tricksy","twitchy","twinkle","warm","wee","wild","witty","wonder","wood")
#>

$ForestFriends = @()
$AllForestPlants = @("aloe","apple","bean","beet","berry","birch","bloom","bush","cedar","cherry","chive","clover","dill","dwale","elm","fern","flower","fig","fir","fruit","fungus","garlic","ginger","grass","hazel","hemlock","holly","iris","ivy","leek","lilly","maple","melon","mint","moss","mushroom","nettle","oak","onion","orchid","paddy","pansy","parsley","parsnip","pea","peach","pepper","pine","plum","pumpkin","poppy","rose","shroom","shrub","spud","tater","truffle","tree","tulip","turnip","weed","willow","wort","yew")
$ForestAnimalFriends = @("badger","beaver","bee","beetle","bird","bug","bunny","cricket","duck","fawn","ferret","fox","frog","goose","grub","hare","hedgehog","mouse","moth","newt","owl","rabbit","robin","slug","snail","sparrow","squirrel","swan","toad","woodpecker","worm")
$ForestPlantFriends = @("berry","birch","bush","cedar","clover","elm","fern","flower","fig","fir","fruit","fungus","hazel","hemlock","holly","ivy","lilly","maple","moss","mushroom","nettle","oak","pansy","pine","shroom","shrub","truffle","tree","willow","yew")
$ForestFriends += $ForestAnimalFriends
$ForestFriends += $ForestPlantFriends

#region The following arrays may be implemented in the future. Unsure.
$ForestFoods = @("apple","bean","beet","berry","bug","bun","biscuit","butter","cake","candy","cherry","chive","cream","dill","dumpling","egg","fig","fruit","fungus","garlic","ginger","grub","gum","hazel","hemlock","honey","jam","jelly","leek","maple","melon","mint","muffin","mushroom","nettle","nut","onion","parsley","parsnip","pea","peach","pepper","plum","pumpkin","root","sap","seed","shroom","spice","spud","sugar","syrup","tea","tater","truffle","turnip","waffle","water","wort")
$ForestLocales = @()
$ForestFluids = @("cider","dew","honey","juice","milk","nectar","pond","puddle","sap","soup","stew","tea","tonic","water")
#endregion

#region Dynamically populate rhyme sounds
#region Rock
foreach($Word in $RockNounObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($RockRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$RockRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $RockAgentObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($RockRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$RockRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $RockAdjectiveObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($RockRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$RockRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}
#endregion

#region Forest
foreach($Word in $ForestNounObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($ForestRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$ForestRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $ForestAgentObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($ForestRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$ForestRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

}

foreach($Word in $ForestAdjectiveObjects.IPA){

    foreach($Number in (4,3,2)){

        $Word = $Word.Replace('ˈ','')
        $Word = $Word.Replace('ˌ','')

        $SubStringLength = ''
        $SubStringLength = $Number
        if($Word.Length -lt $SubStringLength){$SubStringLength = $Word.Length}
    
        $StartIndex = ''
        $StartIndex = $Word.Length - $Number - 1
        if($StartIndex -lt 0){$StartIndex = 0}
    
        $Construct = ''
        $Construct = $Word.Substring($StartIndex,$SubStringLength)

        if(($ForestRhymingSoundsDynamic -notcontains $Construct) -and ($Construct.Length -gt 1)){$ForestRhymingSoundsDynamic += $Construct}

        if($Error.Count -gt 0){Write-Host "$Word" -ForegroundColor Red;$Error.Clear()}
    
    }

} 
#endregion
#endregion

function Get-Alliterative {

    Param(
        [parameter(Mandatory=$True)]
        [ValidateSet("Rock","Forest")]
        [string]$GnomeType,
        [parameter(Mandatory=$True)]
        [ValidateSet("Noun","Agent","Adjective")]
        [string]$Set1,
        [parameter(Mandatory=$True)]
        [ValidateSet("Noun","Agent","Adjective")]
        [string]$Set2,
        [parameter(Mandatory=$False)]
        [bool]$ReturnSet
    )

    $CommonSounds = ''
    $Try = $true

    while($Try -eq $true){

        if((Get-Variable "$($GnomeType)$($Set1)PhoneticUniques").Value.Count -gt (Get-Variable "$($GnomeType)$($Set2)PhoneticUniques").Value.Count){
                
            $CommonSounds = (Get-Variable "$($GnomeType)$($Set2)PhoneticUniques").Value.trim() | ?{(Get-Variable "$($GnomeType)$($Set1)PhoneticUniques").Value -contains $_}
                    
        }else{
                
            $CommonSounds = (Get-Variable "$($GnomeType)$($Set1)PhoneticUniques").Value.trim() | ?{(Get-Variable "$($GnomeType)$($Set2)PhoneticUniques").Value -contains $_}
                    
        }

        foreach($Sound in $CommonSounds){
    
            $Wordbank1 = ''
            $Wordbank1 = (Get-Variable "$($GnomeType)$($Set1)Objects").Value | ?{($_.IPA -like "$($Sound)*") -or ($_.IPA -like "$('ˈ')$($Sound)*")}

            $Wordbank2 = ''
            $Wordbank2 = (Get-Variable "$($GnomeType)$($Set2)Objects").Value | ?{($_.IPA -like "$($Sound)*") -or ($_.IPA -like "$('ˈ')$($Sound)*")}

            foreach($Word in $Wordbank1){
        
                if($Wordbank2.Word -contains $Word.Word){
            
                    $KillRoll = ''
                    $KillRoll = Get-Random -Minimum 1 -Maximum 3

                    if($KillRoll -eq 1){$Wordbank1 = $Wordbank1 | ?{$_.Word -notlike "$($Word.Word)"}}
                    if($KillRoll -eq 2){$Wordbank2 = $Wordbank2 | ?{$_.Word -notlike "$($Word.Word)"}}
                
                }

            }

            if(($Wordbank1.Count -gt 0) -and ($Wordbank2.Count -gt 0)){$Try = $false}

        }

        #if(($Wordbank1.Count -gt 0) -and ($Wordbank2.Count -gt 0)){$Try = $false}

    }

    $StartingSound = ''
    $StartingSound = $CommonSounds[(Get-Random -Minimum 0 -Maximum ($CommonSounds.Count))]
    if($ReturnSet -eq $True){$CommonSounds}else{$StartingSound}

}

<#
function Get-Rhyming {

    Param(
        [parameter(Mandatory=$True)]
        [ValidateSet("Rock","Forest")]
        [string]$GnomeType,
        [parameter(Mandatory=$True)]
        [ValidateSet("Noun","Agent","Adjective")]
        [string]$Set1,
        [parameter(Mandatory=$True)]
        [ValidateSet("Noun","Agent","Adjective")]
        [string]$Set2,
        [parameter(Mandatory=$False)]
        [bool]$ReturnSet
    )

    $ObjectSet1 = ''
    $ObjectSet1 = (Get-Variable "$($GnomeType)$($Set1)Objects").Value

    $ObjectSet2 = ''
    $ObjectSet2 = (Get-Variable "$($GnomeType)$($Set2)Objects").Value

    $RhymingSet1 = @()
    $RhymingSet2 = @()

    $WordPool1 = @()
    $WordPool2 = @()

    foreach($Sound in (Get-Variable "$($GnomeType)RhymingSounds").Value){
    
        foreach($Word1 in $ObjectSet1){
            
            $SubstringStart1 = ''
            $SubstringStart1 = if($Word1.IPA.Length - 1 - $Sound.Length -ge 0){$Word1.IPA.Length - 1 - $Sound.Length}else{0}

            $SubstringCount1 = ''
            $SubstringCount1 = $Word1.IPA.Length - $SubstringStart1 - 1

            if(($Word1.IPA.Substring($SubstringStart1,$SubstringCount1) -like "*$($Sound)*") -and ($RhymingSet1 -notcontains $Sound)){$RhymingSet1 += $Sound}
            if($Word1.IPA.Substring($SubstringStart1,$SubstringCount1) -like "*$($Sound)*"){$WordPool1 += [pscustomobject]@{Word=$Word1.Word;IPA=$word1.IPA;RhymingSound=$Sound}}

        }

        foreach($Word2 in $ObjectSet2){
            
            $SubstringStart2 = ''
            $SubstringStart2 = if($Word2.IPA.Length - 1 - $Sound.Length -ge 0){$Word2.IPA.Length - 1 - $Sound.Length}else{0}

            $SubstringCount2 = ''
            $SubstringCount2 = $Word2.IPA.Length - $SubstringStart2 - 1

            if(($Word2.IPA.Substring($SubstringStart2,$SubstringCount2) -like "*$($Sound)*") -and ($RhymingSet2 -notcontains $Sound)){$RhymingSet2 += $Sound}
            if($Word2.IPA.Substring($SubstringStart2,$SubstringCount2) -like "*$($Sound)*"){$WordPool2 += [pscustomobject]@{Word=$Word2.Word;IPA=$word2.IPA;RhymingSound=$Sound}}

        }

    }

    $RhymingSet = $RhymingSet1 | ?{$RhymingSet2 -contains $_}

    if($ReturnSet -eq $True){$RhymingSet}else{
    
        $RandomSound = ""
        $RandomSound = $RhymingSet[(Get-Random -Minimum 0 -Maximum ($RhymingSet.Count))]

        $Name = ""
        $NameConstructor1 = ""
        $NameConstructor2 = ""

        $NameConstructor1 = $WordPool1 | ?{$_.RhymingSound -eq $RandomSound}
        if(($NameConstructor1 | Measure).Count -gt 1){$NameConstructor1 = $NameConstructor1[(Get-Random -Minimum 0 -Maximum ($NameConstructor1.Count))]}

        $NameConstructor2 = $WordPool2 | ?{$_.RhymingSound -eq $RandomSound}
        if(($NameConstructor2 | Measure).Count -gt 1){$NameConstructor2 = $NameConstructor2[(Get-Random -Minimum 0 -Maximum ($NameConstructor2.Count))]}

        "$($NameConstructor1.WOrd)$($NameConstructor2.Word)"

    }

}
#>

function Get-RhymingDynamic {

    Param(
        [parameter(Mandatory=$True)]
        [ValidateSet("Rock","Forest")]
        [string]$GnomeType,
        [parameter(Mandatory=$True)]
        [ValidateSet("Noun","Agent","Adjective")]
        [string]$Set1,
        [parameter(Mandatory=$True)]
        [ValidateSet("Noun","Agent","Adjective")]
        [string]$Set2,
        [parameter(Mandatory=$False)]
        [bool]$ReturnSet
    )

    $ObjectSet1 = ''
    $ObjectSet1 = (Get-Variable "$($GnomeType)$($Set1)Objects").Value

    $ObjectSet2 = ''
    $ObjectSet2 = (Get-Variable "$($GnomeType)$($Set2)Objects").Value

    $RhymingSet1 = @()
    $RhymingSet2 = @()

    $WordPool1 = @()
    $WordPool2 = @()

    foreach($Sound in (Get-Variable "$($GnomeType)RhymingSoundsDynamic").Value){
    
        foreach($Word1 in $ObjectSet1){
            
            $StartIndex = ''
            $StartIndex = $Word1.IPA.Length - $Sound.Length
            if($StartIndex -lt 0){$StartIndex = 0}

            $IndexLength = ''
            $IndexLength = $Sound.Length
            if($IndexLength -gt $Word1.IPA.Length){$IndexLength = $Word1.IPA.Length}

            if(($Word1.IPA.Substring($StartIndex,$IndexLength) -like "*$($Sound)*") -and ($RhymingSet1 -notcontains $Sound)){$RhymingSet1 += $Sound}
            if($Word1.IPA.Substring($StartIndex,$IndexLength) -like "*$($Sound)*"){$WordPool1 += [pscustomobject]@{Word=$Word1.Word;IPA=$word1.IPA;RhymingSound=$Sound}}

            if($error.Count -gt 0){$Word1;$error}
            $error.Clear()

        }

        foreach($Word2 in $ObjectSet2){
            
            $StartIndex = ''
            $StartIndex = $Word2.IPA.Length - $Sound.Length
            if($StartIndex -lt 0){$StartIndex = 0}

            $IndexLength = ''
            $IndexLength = $Sound.Length
            if($IndexLength -gt $Word2.IPA.Length){$IndexLength = $Word2.IPA.Length}

            if(($Word2.IPA.Substring($StartIndex,$IndexLength) -like "*$($Sound)*") -and ($RhymingSet2 -notcontains $Sound)){$RhymingSet2 += $Sound}
            if($Word2.IPA.Substring($StartIndex,$IndexLength) -like "*$($Sound)*"){$WordPool2 += [pscustomobject]@{Word=$Word2.Word;IPA=$word2.IPA;RhymingSound=$Sound}}

            if($error.Count -gt 0){$Word2;$error}
            $error.Clear()

        }

    }

    $RhymingSet = $RhymingSet1 | ?{$RhymingSet2 -contains $_}

    if($ReturnSet -eq $True){$RhymingSet}else{
    
        While($Try -ne $False){

            $RandomSound = ""
            $RandomSound = $RhymingSet[(Get-Random -Minimum 0 -Maximum ($RhymingSet.Count))]

            $Name = ""
            $NameConstructor1 = ""
            $NameConstructor2 = ""

            $NameConstructor1 = $WordPool1 | ?{$_.RhymingSound -eq $RandomSound}
            if(($NameConstructor1 | Measure).Count -gt 1){$NameConstructor1 = $NameConstructor1[(Get-Random -Minimum 0 -Maximum ($NameConstructor1.Count))]}

            $NameConstructor2 = $WordPool2 | ?{$_.RhymingSound -eq $RandomSound}
            if(($NameConstructor2 | Measure).Count -gt 1){$NameConstructor2 = $NameConstructor2[(Get-Random -Minimum 0 -Maximum ($NameConstructor2.Count))]}

            if($NameConstructor1.Word -ne $NameConstructor2.Word){$Try = $False}

        }
            
            $Surname = ''
            if($NameConstructor1.Word[-1] -eq $NameConstructor2.Word[0]){$Surname = "$($NameConstructor1.Word)-$($NameConstructor2.Word)"}else{$Surname = "$($NameConstructor1.Word)$($NameConstructor2.Word)"}
            if(($NameConstructor1.Word[-1] -eq "t") -and ($NameConstructor2.Word[0] -eq "h")){$Surname = "$($NameConstructor1.Word)-$($NameConstructor2.Word)"}

            $Surname = "$($Surname.Substring(0,1).ToUpper())"+"$($Surname.Substring(1))"

            $Surname

    }

}

function Get-GnomeSurname {
    
    Param(
        [parameter(Mandatory=$False)]
        [ValidateSet("Rock","Forest")]
        [string]$Type,
        [parameter(Mandatory=$False)]
        [ValidateSet("Random","Alliterative","Rhyming")]
        [string]$Mode
    )

    if($Mode -eq ''){$Mode = "Random"}

    if(!$Type){if((Get-Random -Minimum 1 -Maximum 3) -eq 1){$Type = "Rock"}else{$Type = "Forest"}}

    $Surname = ''

    if($Type -eq "Rock"){
        
        $Roll = ''
        #Additional logic needed to make satisfying combinations of random nouns - increase Maximum to 5 once/if this is done
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Mode -eq 'Alliterative'){

            if($Roll -eq 1){

                $StartingSound = ''
                $StartingSound = Get-Alliterative -GnomeType Rock -Set1 Agent -Set2 Adjective

                $Options1 = ''
                $Options1 = $RockAdjectiveObjects | ?{($_.IPA -like "$($StartingSound)*") -or($_.IPA -like "ˈ$($StartingSound)*")}

                $1 =''
                $1 = if($Options1.Count -gt 1){($Options1[(Get-Random -Minimum 0 -Maximum ($Options1.Count))]).Word}else{$Options1.Word}

                $Options2 = ''
                $Options2 = $RockAgentObjects | ?{($_.IPA -like "$($StartingSound)*") -or ($_.IPA -like "ˈ$($StartingSound)*")}

                $2 = ''
                $2 = if($Options2.Count -gt 1){($Options2[(Get-Random -Minimum 0 -Maximum ($Options2.Count))]).Word}else{$Options2.Word}

            }

            if($Roll -eq 2){

                $StartingSound = ''
                $StartingSound = Get-Alliterative -GnomeType Rock -Set1 Agent -Set2 Noun

                $Options1 = ''
                $Options1 = $RockNounObjects | ?{($_.IPA -like "$($StartingSound)*") -or($_.IPA -like "ˈ$($StartingSound)*")}

                $1 =''
                $1 = if($Options1.Count -gt 1){($Options1[(Get-Random -Minimum 0 -Maximum ($Options1.Count))]).Word}else{$Options1.Word}

                $Options2 = ''
                $Options2 = $RockAgentObjects | ?{($_.IPA -like "$($StartingSound)*") -or ($_.IPA -like "ˈ$($StartingSound)*")}

                $2 = ''
                $2 = if($Options2.Count -gt 1){($Options2[(Get-Random -Minimum 0 -Maximum ($Options2.Count))]).Word}else{$Options2.Word}

            }

            if($Roll -eq 3){
            
                $StartingSound = ''
                $StartingSound = Get-Alliterative -GnomeType Rock -Set1 Adjective -Set2 Noun

                $Options1 = ''
                $Options1 = $RockAdjectiveObjects | ?{($_.IPA -like "$($StartingSound)*") -or($_.IPA -like "ˈ$($StartingSound)*")}

                $1 =''
                $1 = if($Options1.Count -gt 1){($Options1[(Get-Random -Minimum 0 -Maximum ($Options1.Count))]).Word}else{$Options1.Word}

                $Options2 = ''
                $Options2 = $RockNounObjects | ?{($_.IPA -like "$($StartingSound)*") -or ($_.IPA -like "ˈ$($StartingSound)*")}

                $2 = ''
                $2 = if($Options2.Count -gt 1){($Options2[(Get-Random -Minimum 0 -Maximum ($Options2.Count))]).Word}else{$Options2.Word}

            }

        }
        
        if($Mode -eq 'Rhyming'){
        
            if($Roll -eq 1){

                $Set1 = 'Adjective'

                $Set2 = 'Agent'

            }

            if($Roll -eq 2){

                $Set1 = 'Noun'

                $Set2 = 'Agent'

            }

            if($Roll -eq 3){

                $Set1 = 'Adjective'

                $Set2 = 'Noun'

            }

            $Surname = Get-RhymingDynamic -GnomeType Rock -Set1 $Set1 -Set2 $Set2

        }

        if($Mode -eq 'Random'){

            if($Roll -eq 1){
    
                $1 =''
                $1 = $RockAdjectiveObjects[(Get-Random -Minimum 0 -Maximum ($RockAdjectiveObjects.Count))].Word

                $2 = ''
                $2 = $RockAgentObjects[(Get-Random -Minimum 0 -Maximum ($RockAgentObjects.Count))].Word
        
            }elseif($Roll -eq 2){
    
                $1 =''
                $1 = $RockNounObjects[(Get-Random -Minimum 0 -Maximum ($RockNounObjects.Count))].Word

                $2 = ''
                $2 = $RockAgentObjects[(Get-Random -Minimum 0 -Maximum ($RockAgentObjects.Count))].Word

                if($1 -eq $2.Substring(0,$2.Length - 2)){$1 = $RockAdjectiveObjects[(Get-Random -Minimum 0 -Maximum ($RockAdjectiveObjects.Count))].Word}

            }elseif($Roll -eq 3){
    
                $1 =''
                $1 = $RockAdjectiveObjects[(Get-Random -Minimum 0 -Maximum ($RockAdjectiveObjects.Count))].Word

                $2 = ''
                $2 = $RockNounObjects[(Get-Random -Minimum 0 -Maximum ($RockNounObjects.Count))].Word

                if($1 -eq $2){$2 = $RockAgentObjects[(Get-Random -Minimum 0 -Maximum ($RockAgentObjects.Count))].Word}

            #Additional logic needed to make satisfying combinations of random nouns
            }elseif($Roll -eq 4){
    
                $1 =''
                $1 = $RockNounObjects[(Get-Random -Minimum 0 -Maximum ($RockNounObjects.Count))].Word

                $2 = ''
                $2 = $RockNounObjects[(Get-Random -Minimum 0 -Maximum ($RockNounObjects.Count))].Word

                if($1 -eq $2){$2 = $RockAgentObjects[(Get-Random -Minimum 0 -Maximum ($RockAgentObjects.Count))].Word}

            }

        }

    }

    if($Type -eq "Forest"){

        $Roll = ''
        #Additional logic needed to make satisfying combinations of random nouns - increase Maximum to 5 once/if this is done
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Mode -eq 'Alliterative'){
        
            if($Roll -eq 1){
            
                $StartingSound = ''
                $StartingSound = Get-Alliterative -GnomeType Forest -Set1 Adjective -Set2 Agent

                $Options1 = ''
                $Options1 = $ForestAdjectiveObjects | ?{($_.IPA -like "$($StartingSound)*") -or($_.IPA -like "ˈ$($StartingSound)*")}

                $1 =''
                $1 = if($Options1.Count -gt 1){($Options1[(Get-Random -Minimum 0 -Maximum ($Options1.Count))]).Word}else{$Options1.Word}

                $Options2 = ''
                $Options2 = $ForestAgentObjects | ?{($_.IPA -like "$($StartingSound)*") -or ($_.IPA -like "ˈ$($StartingSound)*")}

                $2 = ''
                $2 = if($Options2.Count -gt 1){($Options2[(Get-Random -Minimum 0 -Maximum ($Options2.Count))]).Word}else{$Options2.Word}

            }

            if($Roll -eq 2){
            
                $StartingSound = ''
                $StartingSound = Get-Alliterative -GnomeType Forest -Set1 Agent -Set2 Noun

                $Options1 = ''
                $Options1 = $ForestNounObjects | ?{($_.IPA -like "$($StartingSound)*") -or($_.IPA -like "ˈ$($StartingSound)*")}

                $1 =''
                $1 = if($Options1.Count -gt 1){($Options1[(Get-Random -Minimum 0 -Maximum ($Options1.Count))]).Word}else{$Options1.Word}

                $Options2 = ''
                $Options2 = $ForestAgentObjects | ?{($_.IPA -like "$($StartingSound)*") -or ($_.IPA -like "ˈ$($StartingSound)*")}

                $2 = ''
                $2 = if($Options2.Count -gt 1){($Options2[(Get-Random -Minimum 0 -Maximum ($Options2.Count))]).Word}else{$Options2.Word}

            }

            if($Roll -eq 3){
            
                $StartingSound = ''
                $StartingSound = Get-Alliterative -GnomeType Forest -Set1 Adjective -Set2 Noun

                $Options1 = ''
                $Options1 = $ForestAdjectiveObjects | ?{($_.IPA -like "$($StartingSound)*") -or($_.IPA -like "ˈ$($StartingSound)*")}

                $1 =''
                $1 = if($Options1.Count -gt 1){($Options1[(Get-Random -Minimum 0 -Maximum ($Options1.Count))]).Word}else{$Options1.Word}

                $Options2 = ''
                $Options2 = $ForestNounObjects | ?{($_.IPA -like "$($StartingSound)*") -or ($_.IPA -like "ˈ$($StartingSound)*")}

                $2 = ''
                $2 = if($Options2.Count -gt 1){($Options2[(Get-Random -Minimum 0 -Maximum ($Options2.Count))]).Word}else{$Options2.Word}

            }

        }
        
        if($Mode -eq 'Rhyming'){
        
            if($Roll -eq 1){

                $Set1 = 'Adjective'

                $Set2 = 'Agent'

            }

            if($Roll -eq 2){

                $Set1 = 'Noun'

                $Set2 = 'Agent'

            }

            if($Roll -eq 3){

                $Set1 = 'Adjective'

                $Set2 = 'Noun'

            }

            $Surname = Get-RhymingDynamic -GnomeType Forest -Set1 $Set1 -Set2 $Set2

        }

        if($Mode -eq 'Random'){

           if($Roll -eq 1){
    
                $Error.Clear()

                $1 =''
                $1 = $ForestAdjectiveObjects[(Get-Random -Minimum 0 -Maximum ($ForestAdjectiveObjects.Count))].Word

                $2 = ''
                $2 = $ForestAgentObjects[(Get-Random -Minimum 0 -Maximum ($ForestAgentObjects.Count))].Word

            }elseif($Roll -eq 2){
    
                $Error.Clear()

                $1 =''
                $1 = $ForestNounObjects[(Get-Random -Minimum 0 -Maximum ($ForestNounObjects.Count))].Word

                $2 = ''
                $2 = $ForestAgentObjects[(Get-Random -Minimum 0 -Maximum ($ForestAgentObjects.Count))].Word

                if($1 -eq $2.Substring(0,$2.Length - 2)){$1 = $ForestAdjectiveObjects[(Get-Random -Minimum 0 -Maximum ($ForestAdjectiveObjects.Count))].Word}

            #Additional logic needed to make satisfying combinations of random nouns
            }elseif($Roll -eq 3){

                $Error.Clear()
    
                $1 =''
                $1 = $ForestAdjectiveObjects[(Get-Random -Minimum 0 -Maximum ($ForestAdjectiveObjects.Count))].Word

                $2 = ''
                $2 = $ForestNounObjects[(Get-Random -Minimum 0 -Maximum ($ForestNounObjects.Count))].Word

                if($1 -eq $2){$2 = $ForestAgentObjects[(Get-Random -Minimum 0 -Maximum ($ForestAgentObjects.Count))].Word}

            #Additional logic needed to make satisfying combinations of random nouns
            }elseif($Roll -eq 4){
    
                $Error.Clear()

                $1 =''
                $1 = $ForestNounObjects[(Get-Random -Minimum 0 -Maximum ($ForestNounObjects.Count))].Word

                $2 = ''
                $2 = $ForestNounObjects[(Get-Random -Minimum 0 -Maximum ($ForestNounObjects.Count))].Word

                if($1 -eq $2){$2 = $ForestAgentObjects[(Get-Random -Minimum 0 -Maximum ($ForestAgentObjects.Count))].Word}

            }

            if($2 -like "friend"){$1 = $ForestFriends[(Get-Random -Minimum 0 -Maximum ($ForestFriends.Count))]}

        }

    }

    if($Mode -ne 'Rhyming'){

        if($1[-1] -eq $2[0]){$Surname = "$($1)-$($2)"}else{$Surname = "$($1)$($2)"}

        if(($1[-1] -eq "t") -and ($2[0] -eq "h")){$Surname = "$($1)-$($2)"}

    }

    $Surname = "$($Surname.Substring(0,1).ToUpper())"+"$($Surname.Substring(1))"

    $Surname

}

#Remove matching on two IPA characters as valid rhymes, (avoiding strange vowel sounds being matched as with "Canenoggin," which matches on "ɪn" ("keɪn" and "ˈnɑɡɪn")
#Add additional elements for objects: tags, (friends, animals, plants, etc.) logical prefixes/suffixes
#Add "cks" --> "x", "s" --> "z" switch for rock gnomes?
