Attribute VB_Name = "ProjectActivity"
Function sumColor(matchColor As Range, sumRange As Range) As Double
    Dim cell As Range
    Dim ccolor As Range
    
    sumColor = 0
    
    For Each cell In sumRange
        For Each ccolor In matchColor
            If cell.Interior.Color = ccolor.Cells(1, 1).Interior.Color Then
                sumColor = sumColor + cell.Value
            End If
        Next ccolor
    Next cell
End Function

