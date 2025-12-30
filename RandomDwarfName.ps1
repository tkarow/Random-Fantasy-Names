function Get-DwarfName{

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

    $FemalePrefixes = @("Mil","El","Mal","Ham","Hil","Rag")
    $MalePrefixes = @("Thor","Kor","Kron","Thrim","O","Ham","Go","Harn","Rag")
    $MiddleSyllables = @("gor","a","an","gon","don","on","na")
    $LastSyllables = @("kor","gar","dor","gon","on","grot","orn","rok")
    $MaleLastSyllables = @("grim","dus","gorn","gron","do","gus")
    $FemaleSuffixes = @("a","ia","da")

    if($Gender -eq "Female"){
        
        $Name = "$($FemalePrefixes[(Get-Random -Minimum 0 -Maximum ($FemalePrefixes.Count))])"

    }elseif($Gender -eq "Male"){

        $Name = "$($MalePrefixes[(Get-Random -Minimum 0 -Maximum ($MalePrefixes.Count))])"

    }

    $AddMiddleSyllable = $True
    $MiddleSyllableLikelihood = 70

    while($AddMiddleSyllable -eq $True){
        
        if((Get-Random -Minimum 1 -Maximum 101) -ge $MiddleSyllableLikelihood){
            
            $Name = "$($Name)$($MiddleSyllables[(Get-Random -Minimum 0 -Maximum ($MiddleSyllables.Count))])"

            $MiddleSyllableLikelihood = $MiddleSyllableLikelihood * 1.3

        }else{

            $AddMiddleSyllable = $False

        }
        
    }

    if(($Gender -eq "Male") -and ((Get-Random -Minimum 1 -Maximum 101) -ge 35)){
        
        $Name = "$($Name)$($MaleLastSyllables[(Get-Random -Minimum 0 -Maximum ($MaleLastSyllables.Count))])"

    }else{
    
        $Name = "$($Name)$($LastSyllables[(Get-Random -Minimum 0 -Maximum ($LastSyllables.Count))])"

    }

    if($Gender -eq "Female"){
    
        $Name = "$($Name)$($FemaleSuffixes[(Get-Random -Minimum 0 -Maximum ($FemaleSuffixes.Count))])"

    }

    $Name = $Name.replace('aa','a')
    $Name = $Name.replace('ee','e')
    $Name = $Name.replace('oo','o')

    if($Name -match "[aeiou][aeiou]"){
    
        $Name = $Name -Replace "(.*[a|e|i|o|u])([a|e|i|o|u].*)", '$1-$2'
    
    }

    $Name

}
