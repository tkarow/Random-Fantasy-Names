function Get-ElfName{

    Param(

    [Parameter(Mandatory=$False)]
    [ValidateSet("Male","Female")]
    $Gender

    )

    if(!$Gender){
    
        if((Get-Random -Minimum 1 -Maximum 101) -ge 25){
        
            $Gender = "Male"

        }else{
        
            $Gender = "Female"

        }

    }

    $FirstSyllables = @("Tal","Den","Lae","Bel","El","Elk","Ben")
    $MiddleSyllables = @("an","thal","dra","len","thor","end","le","la")
    $LastSyllables = @("dryl","as","kor","or","ir","dren","len","dor")
    $MaleLastSyllables = @("fast","rond","born","il","dil","rod")
    $FemaleSuffixes = @("a","i","ei","la","li","lei","dra","da")

    $Name = "$($FirstSyllables[(Get-Random -Minimum 0 -Maximum ($FirstSyllables.Count))])"

    $AddMiddleSyllable = $True
    $MiddleSyllableLikelihood = 20

    while($AddMiddleSyllable -eq $True){
        
        if((Get-Random -Minimum 1 -Maximum 101) -ge $MiddleSyllableLikelihood){
            
            $Name = "$($Name)$(if((Get-Random -Minimum 0 -Maximum 101) -gt 60){"`'"})$($MiddleSyllables[(Get-Random -Minimum 0 -Maximum ($MiddleSyllables.Count))])"

            if($MiddleSyllableLikelihood -eq 20 ){
            
                $MiddleSyllableLikelihood = 42

            }

            $MiddleSyllableLikelihood = $MiddleSyllableLikelihood * 1.5


        }else{

            $AddMiddleSyllable = $False

        }
        
    }

    if(($Gender -eq "Male") -and ((Get-Random -Minimum 1 -Maximum 101) -ge 45)){
        
        $Name = "$($Name)$($MaleLastSyllables[(Get-Random -Minimum 0 -Maximum ($MaleLastSyllables.Count))])"

    }elseif((Get-Random -Minimum 1 -Maximum 101) -ge 40){
    
        $Name = "$($Name)$($LastSyllables[(Get-Random -Minimum 0 -Maximum ($LastSyllables.Count))])"

    }

    if(($Gender -eq "Male") -and ($Name -like "*a")){
    
        if((Get-Random -Minimum 1 -Maximum 101) -ge 50){

            $Name = "$($Name.Substring(0,$Name.Length-1))un"
        
        }elseif((Get-Random -Minimum 1 -Maximum 101) -ge 50){
        
            $Name = "$($Name.Substring(0,$Name.Length-1))us"
        
        }else{
        
            $Name = "$($Name.Substring(0,$Name.Length-1))o"
        
        }

    }

    if($Gender -eq "Female"){
    
        $Name = "$($Name)$($FemaleSuffixes[(Get-Random -Minimum 0 -Maximum ($FemaleSuffixes.Count))])"

    }

    $Name = $Name.replace('aa','a')
    $Name = $Name.replace('ee','e')
    $Name = $Name.replace('rr','r')
    $Name = $Name.replace('dd','d')
    $Name = $Name.replace('ll',"l'l")

    $Name

}
