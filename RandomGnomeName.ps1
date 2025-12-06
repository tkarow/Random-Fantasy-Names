#This is a set of curated syllables, sounds, and words that reflect my idea of fantasy gnome name constructors. I've written logic to combine them into aesthetically pleasing names after iterating on the results. This is a work in progress, and subject to taste.

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

$RockNouns = @("aim","angle","bang","bauble","beard","bell","belly","belt","benċ","book","boot","bottle","brass","buckle","buddy","bug","button","candle","candy","cane","cap","cavern","ċime","ċip","ċortle","clock","clog","coal","cog","copper","craft","crate","crumb","cubby","crystal","cycle","design","dial","dingle","doodad","drill","drip","engine","fault","figure","finger","fire","fizzle","flange","flip","flux","fumble","fungus","fuse","gadget","garnet","gas","gavel","gear","gem","gimmick","gizmo","glimmer","glove","grub","hammer","hatċ","hour","ink","jig","jewel","key","knack","lantern","law","ledger","lesson","letter","light","link","lock","lore","map","mind","mine","measure","metal","mill","mine","name","needle","notċ","nubbin","number","pack","paper","pattern","pin","pinky","pipe","plan","pocket","print","project","pulley","quartz","quill","quiver","rack","rascal","ratċet","rock","ruby","ruin","rule","rump","rust","root","sapphire","saw","sċeme","sċool","screw","scuttle","seal","set","ʃoe","ʃop","ʃovel","ʃroom","slot","smock","snack","song","soot","soup","spell","spring","spunk","song","sprocket","stamp","steam","stone","story","study","sugar","switċ","system","tally","þimble","þingy","þread","þumb","time","toe","tome","tongue","tooþ","tool","toy","trick","trinket","tummy","tunnel","wagon","wax","way","whatsit","widget","wit","well","wheel","whistle","work","worm","wrenċ")
$RockAgents = @("belly","bender","berger","binder","biter","bits","breaker","brow","buddy","buffer","builder","caster","catċer","ċecker","ċiller","ċipper","ċum","climber","clunker","cotter","counter","crafter","cutter","dancer","digger","driller","dinger","dripper","dropper","fellow","file","finder","fixer","framer","fuser","giver","glitter","gnome","goggles","helmer","hemmer","heimer","hider","holder","home","hopper","-inker","-itċer","jigger","joker","judger","keeper","kicker","knacker","knickers","knocker","locker","lover","mapper","mate","meister","meter","meyer","monċ","more","munċer","nacker","packer","pants","picker","plotter","puffer","pocket","poliʃ","prank","printer","puller","punċer","puʃer","presser","maker","mallow","maker","marker","mender","miner","noggin","officer","planner","pocket","putter","reader","roller","rooter","scamp","scooper","sealer","seeker","setter","ʃaper","ʃarer","ʃiner","signer","sinker","snacker","snatċer","snipper","speaker","spinner","stamper","stopper","sweeper","taster","teaċer","teller","tender","þrower","þumper","ticker","tinker","tricker","tucker","twitċer","watċer","winder","witċer","worker","writer")
$RockAdjectives = @("best","brass","bright","candy","ċeery","ċitty","ċrome","clean","clever","cold","copper","crackle","crafty","crumb","deep","dizzy","double","drive","dusty","fair","fault","fraggle","frolic","funny","gem","gold","good","grumble","happy","hard","high","inky","itċy","knotty","long","lost","loud","low","magic","munċ","naughty","next","noble","odd","old","over","pocket","power","quartz","quick","rusty","safe","ʃort","silver","sledge","sly","soft","soot","spore","steady","strict","sweet","tender","tinker","tiny","top","trick","tricksy","twitċy","under","twinkle","warm","wee","witty","wonder","work")

$RockAlliteritiveNounUniques = $RockNouns | sort | %{$_[0]} | Get-Unique
$RockAlliteritiveAgentUniques = $RockAgents | sort | %{$_[0]} | Get-Unique
$RockAlliteritiveAdjectiveUniques = $RockAdjectives | sort | %{$_[0]} | Get-Unique

#region Expansion
#Shoutout to tophonetics.com for the (American) IPA phonetic transcriptions
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
			IPA=""
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
			IPA="ˈdaɪəl","daɪl"
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
			IPA="ˈɛnʤən","ˈɪnʤən"
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
			IPA="ˈfaɪər","faɪr"
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
			IPA="ˈaʊər","aʊr"
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
			IPA="ˈʤuəl","ʤul"
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
			IPA="lɔ","lɑ"
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
			Word=“mine";
			IPA="maɪn"
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
			IPA=""
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
			IPA="ˈprɑʤɛkt","prəˈʤɛkt"
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
			IPA="ˈræʧət","rætʧət"
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
			IPA="ˈruən","ˈruɪn"
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
			IPA=""
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
			IPA="sprɪŋ","spəˈrɪŋ"
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
			IPA=""
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
			Word=“-inker";
			IPA="-ˈɪŋkər"
		},
		[pscustomobject]@{
			Word=“-itcher";
			IPA="-ˈɪʧər"
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
			IPA=""
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
			IPA="ˈpɑlɪʃ","ˈpoʊlɪʃ"
		},
		[pscustomobject]@{
			Word=“prank";
			IPA="præŋk"
		},
		[pscustomobject]@{
			Word=“printer";
			IPA="ˈprɪntər","ˈprɪnər"
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
			IPA=""
		},
		[pscustomobject]@{
			Word=“officer";
			IPA="ˈɔfəsər","ˈɔfɪsər"
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
			IPA=""
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
			IPA="ˈwɪndər","ˈwaɪndər"
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
			IPA=""
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
			IPA="ɡʊd","ɡɪd"
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
			IPA="sɑft","sɔft"
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
			IPA="tɑp","tɔp"
		},
		[pscustomobject]@{
			Word=“trick";
			IPA="trɪk"
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

#endregion

#region The following arrays may be implemented in the future. Unsure.
$RockFriends = @()
$RockAnimalFriends = @("ant","bug","grub","worm")
$RockPlantFriends = @("muʃroom","root","ʃroom")
$RockFriends += $RockAnimalFriends
$RockFriends += $RockPlantFriends
$RockLocales = @("class","cavern","mine","office","sċool","ʃop","tunnel")
$RockFluids = @("oil","water")
#endregion

$ForestNouns = @("aloe","acorn","alder","apple","autumn","barb","bark","basket","bean","beard","bed","bee","beet","bell","belly","berry","birċ","blanket","bloom","bobbin","bottle","bough","breeze","bubble","buckle","bud","buddy","bug","bulb","bur","buscuit","buʃ","butter","button","candle","candy","cane","cap","cedar","ċerry","cider","ċive","circle","cloud","clover","comb","conker","craft","cream","critter","crumb","crystal","cup","day","daze","dingle","dew","dill","dream","drip","dumpling","dusk","dwale","earþ","egg","elder","elm","fern","flip","flower","field","fig","finger","fir","fizzle","forest","fork","fruit","fumble","fungus","game","garden","garland","garlic","germ","ginger","glade","glove","grass","grub","harvest","hazel","hearþ","hedge","hemlock","hive","hollow","holly","home","honey","horn","hunt","iris","ivy","jam","land","leaf","leek","light","lilly","litter","lore","magic","maple","marʃ","meadow","melon","milk","mint","moon","morning","moss","mud","muffin","muʃroom","nap","nature","nectar","needle","nest","nettle","night","nubbin","nut","oak","oaþ","onion","orċid","paddy","pansy","parsley","parsnip","patċ","paþ","pea","peaċ","pepper","petal","pillow","pine","pinky","pipe","plum","pocket","pond","poppy","pot","prank","promise","prune","puddle","puff","pumpkin","rain","rascal","root","rose","sap","scuttle","seed","ʃade","ʃoe","ʃoot","ʃroom","ʃrub","sky","slug","snail","spice","spoon","snack","song","soup","spell","splinter","spore","song","sprig","spring","spud","spruce","spunk","stem","stone","stew","story","sugar","summer","sun","star","stick","stream","stump","syrup","tater","tea","þimble","þistle","þorn","þread","timber","tonic","truffle","trunk","þumb","toe","tongue","tooþ","tree","tuft","tulip","turnip","twig","vision","waffle","wall","water","wax","wind","wit","weed","well","whistle","willow","winter","wiʃ","wisp","wode","wood","wort","yew")
$ForestAgents = @("belly","berry","biter","bits","bobber","bruʃ","buddy","bun","buzzer","cake","caller","caster","catċer","ċiller","ċum","climber","cooker","crafter","critter","dancer","dinger","dreamer","dropper","fellow","field","finder","fixer","flicker","flitter","flower","friend","friend","friend","gnome","giver","grower","gum","heimer","helmer","hider","holder","home","hopper","hummer","hunter","-itċer","jelly","joker","juicer","keeper","knickers","knocker","knot","lover","maker","mallow","mannin","mate","meister","mender","meyer","monċ","more","munċ","munċer","namer","noggin","pants","picker","pocket","planter","player","plucker","prank","puffer","puller","puʃer","putter","patċer","pocket","ranger","rooter","rump","sage","scamp","scratċer","seeker","seer","ʃaper","ʃarer","sipper","smoker","snacker","snatċer","speaker","splitter","spinner","stamper","stinger","stitċer","stopper","straw","supper","taster","teaċer","teller","tender","þrower","þumper","tinker","toker","tracker","trapper","tricker","tucker","tumbler","tummy","twitċer","vine","wander","watċer","weaver","weeder","wicker","wiʃer","witċer","worker")
$ForestAdjectives = @("bright","butter","calm","candy","ċeery","ċortle","clean","clever","cold","cozy","crafty","crumb","dizzy","double","early","easy","fair","fey","frolic","funny","glad","good","green","grumble","half","happy","hard","high","humming","itċy","jelly","lax","long","lost","loud","low","magic","mellow","muddy","munċ","naughty","nutty","oak","odd","over","pocket","puff","quick","ripe","ʃady","ʃort","silver","sly","soft","spore","steady","stink","sugar","sunny","sweet","tender","þunder","tiny","tricksy","twitċy","twinkle","warm","wee","wild","witty","wonder","wood")
$ForestFriends = @()
$AllForestPlants = @("aloe","apple","bean","beet","berry","birċ","bloom","buʃ","cedar","ċerry","ċive","clover","dill","dwale","elm","fern","flower","fig","fir","fruit","fungus","garlic","ginger","grass","hazel","hemlock","holly","iris","ivy","leek","lilly","maple","melon","mint","moss","muʃroom","nettle","oak","onion","orċid","paddy","pansy","parsley","parsnip","pea","peaċ","pepper","pine","plum","pumpkin","poppy","rose","ʃroom","ʃrub","spud","tater","truffle","tree","tulip","turnip","weed","willow","wort","yew")
$ForestAnimalFriends = @("badger","beaver","bee","beetle","bird","bug","bunny","cricket","duck","fawn","ferret","fox","frog","goose","grub","hare","hedgehog","mouse","moþ","newt","owl","rabbit","robin","slug","snail","sparrow","squirrel","swan","toad","woodpecker","worm")
$ForestPlantFriends = @("berry","birċ","buʃ","cedar","clover","elm","fern","flower","fig","fir","fruit","fungus","hazel","hemlock","holly","ivy","lilly","maple","moss","muʃroom","nettle","oak","pansy","pine","ʃroom","ʃrub","truffle","tree","willow","yew")
$ForestFriends += $ForestAnimalFriends
$ForestFriends += $ForestPlantFriends




#region The following arrays may be implemented in the future. Unsure.
$ForestFoods = @("apple","bean","beet","berry","bug","bun","buscuit","butter","cake","candy","ċerry","ċive","cream","dill","dumpling","egg","fig","fruit","fungus","garlic","ginger","grub","gum","hazel","hemlock","honey","jam","jelly","leek","maple","melon","mint","muffin","muʃroom","nettle","nut","onion","parsley","parsnip","pea","peaċ","pepper","plum","pumpkin","root","sap","seed","ʃroom","spice","spud","sugar","syrup","tea","tater","truffle","turnip","waffle","water","wort")
$ForestLocales = @()
$ForestFluids = @("cider","dew","honey","juice","milk","nectar","pond","puddle","sap","soup","stew","tea","tonic","water")
#endregion

function Get-GnomeSurname {
    
    Param(
        [parameter(Mandatory=$False)]
        [ValidateSet("Rock","Forest")]
        [string]$Type,
        [parameter(Mandatory=$False)]
        [switch]$Alliterative
    )

    if(!$Type){if((Get-Random -Minimum 1 -Maximum 3) -eq 1){$Type = "Rock"}else{$Type = "Forest"}}

    $Surname = ''

    if($Type -eq "Rock"){
        
        $Roll = ''
        #Additional logic needed to make satisfying combinations of random nouns - increase Maximum to 5 once/if this is done
        $Roll = Get-Random -Minimum 1 -Maximum 4

        if($Alliterative){
        
            if($Roll -eq 1){
            
                $CommonCharacters = ''

                if($RockAlliteritiveAgentUniques.Count -gt $RockAlliteritiveAdjectiveUniques.Count){
                
                    $CommonCharacters = $RockAlliteritiveAdjectiveUniques | ?{$RockAlliteritiveAgentUniques -contains $_}
                    
                }else{
                
                    $CommonCharacters = $RockAlliteritiveAgentUniques | ?{$RockAlliteritiveAdjectiveUniques -contains $_}
                    
                }

                $StartingLetter = ''
                $StartingLetter = $CommonCharacters[(Get-Random -Minimum 0 -Maximum ($CommonCharacters.Count))]

                $Options = ''
                $Options = $RockAdjectives | ?{$_[0] -eq $StartingLetter}

                $1 =''
                $1 = if($Options.Count -gt 1){$Options[(Get-Random -Minimum 0 -Maximum ($Options.Count))]}else{$Options}

                $Options = ''
                $Options = $RockAgents | ?{$_[0] -eq $StartingLetter}

                $2 = ''
                $2 = if($Options.Count -gt 1){$Options[(Get-Random -Minimum 0 -Maximum ($Options.Count))]}else{$Options}

            }

        }else{

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

    $Surname = $Surname.Replace("þ","th")
    $Surname = $Surname.Replace("ʃ","sh")
    $Surname = $Surname.Replace("ċ","ch")

    $Surname = "$($Surname.Substring(0,1).ToUpper())"+"$($Surname.Substring(1))"

    $Surname

}

#Add -Aliteration
#Add "cks" --> "x", "s" --> "z" switch?
