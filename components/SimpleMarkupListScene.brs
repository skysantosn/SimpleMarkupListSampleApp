'********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

function init()
    m.simpleMarkupGrid = m.top.findNode("SimpleMarkupGrid")
    m.simpleMarkupGrid.content = getMarkupGridData()
    m.simpleMarkupGrid2 = m.top.findNode("SimpleMarkupGrid2")
    m.simpleMarkupGrid2.content = getMarkupGridData2()
    m.simpleMarkupGrid.setFocus(true)
end function

function getMarkupGridData() as object
    data = CreateObject("roSGNode", "ContentNode")

    for i = 1 to 6
        dataItem = data.CreateChild("SimpleGridItemData")
        dataItem.posterUrl = "http://devtools.web.roku.com/samples/images/Portrait_1.jpg"
        dataItem.labelText = "Grid item" + stri(i)
    end for
    return data
end function

function getMarkupGridData2() as object
    data = CreateObject("roSGNode", "ContentNode")

    for i = 1 to 8
        dataItem = data.CreateChild("SimpleGridItemData")
        dataItem.posterUrl = "http://devtools.web.roku.com/samples/images/Portrait_1.jpg"
        dataItem.labelText = "Grid item" + stri(i)
    end for
    return data
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if NOT press then return false

    if key = "down"
        if m.simpleMarkupGrid.hasFocus()
            jumpToNextGrid()
        end if
    else if key = "up"
        if m.simpleMarkupGrid2.hasFocus()
            jumpToFirstGrid()
        end if
    end if

    return false
end function

function jumpToFirstGrid() as Void
    ' print " "
    ' print "   >> jumpToFirstGrid()"
    previousFocusedIndex = m.simpleMarkupGrid2.itemFocused

    childCount = m.simpleMarkupGrid.content.getChildCount()

    itemsOnLastRow = childCount MOD m.simpleMarkupGrid.numColumns

    firstGridNumRows = (childCount -1) \ m.simpleMarkupGrid.numColumns

    ' print "previousFocusedIndex", previousFocusedIndex
    ' print "childCount", childCount
    ' print "itemsOnLastRow", itemsOnLastRow
    ' print "firstGridNumRows", firstGridNumRows

    if itemsOnLastRow = 0 ' it means it's a full row, not empty
        ' print "  itemsOnLastRow = 0"
        indexToFocus = firstGridNumRows * m.simpleMarkupGrid.numColumns + previousFocusedIndex
    else
        ' print "  itemsOnLastRow <> 0"
        if itemsOnLastRow >= previousFocusedIndex + 1
            indexToFocus = firstGridNumRows * m.simpleMarkupGrid.numColumns + previousFocusedIndex
        else
            indexToFocus = firstGridNumRows * m.simpleMarkupGrid.numColumns + itemsOnLastRow - 1
        end if
    end if
    ' print "indexToFocus", indexToFocus

    m.simpleMarkupGrid.jumpToItem = indexToFocus
    m.simpleMarkupGrid.setFocus(true)
end function

function jumpToNextGrid() as Void
    ' print " "
    ' print "   >> jumpToNextGrid()"

    nextGridChildCount = m.simpleMarkupGrid2.content.getChildCount()

    previousLastRowFocusedIndex = m.simpleMarkupGrid.itemFocused MOD m.simpleMarkupGrid.numColumns

    ' print "nextGridChildCount", nextGridChildCount
    ' print "numColumns", m.simpleMarkupGrid2.numColumns
    ' print "previousLastRowFocusedIndex", previousLastRowFocusedIndex

    if nextGridChildCount > m.simpleMarkupGrid2.numColumns OR nextGridChildCount > previousLastRowFocusedIndex
        indexToFocus = previousLastRowFocusedIndex
    else
        indexToFocus = nextGridChildCount - 1
    end if
    ' print "indexToFocus", indexToFocus

    m.simpleMarkupGrid2.jumpToItem = indexToFocus
    m.simpleMarkupGrid2.setFocus(true)
end function
