-- list of all hyphenated and variated word forms
outputList = {}

-- list of all comments
commentList = {}

rejectedHyphenations = {}

logFile = assert(io.open("variatio.log","w"))

combiningAcute = utf8.char(769)
combiningMacron = utf8.char(772)
combiningTie = utf8.char(865)
combiningDoubleMacron = utf8.char(862)

function createSet(list)
   local set = {}
   for _, l in ipairs(list) do
      set[l] = true
   end
   return set
end

-- digraphs with macrons are not needed, as diphthongs are always long
vowels = createSet{"A","a","Ā","ā","E","e","Ē","ē","I","i","Ī","ī","O","o","Ō",
   "ō","U","u","Ū","ū","Y","y","Ȳ","ȳ","Æ","æ","Œ","œ"}

longVowels = createSet{"Ā","ā","Ē","ē","Ī","ī","Ō","ō","Ū","ū","Ȳ","ȳ"}

shortVowels = createSet{"A","a","E","e","I","i","O","o","U","u","Y","y","Á","á","É","é","Í","í","Ó","ó","Ú","ú","Ý","ý"}

lowercaseConsonants = createSet{"b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","z"}

-- stop consonants, called "(litterae) mutae" in Latin
lowercaseMutae = createSet{"b","p","d","t","g","c","k"}

-- liquid consonants, called "(litterae) liquidae" in Latin
lowercaseLiquidae = createSet{"l","r"}

function firstCharacter(word)
   if utf8.len(word) > 1 then
      return string.sub(word,1,utf8.offset(word,2)-1)
   else
      return word
   end
end

function secondCharacter(word)
   if utf8.len(word) > 2 then
      return string.sub(word,utf8.offset(word,2),utf8.offset(word,3)-1)
   elseif utf8.len(word) == 2 then
      return string.sub(word,utf8.offset(word,2))
   else
      return nil
   end
end

function thirdCharacter(word)
   if utf8.len(word) > 3 then
      return string.sub(word,utf8.offset(word,3),utf8.offset(word,4)-1)
   elseif utf8.len(word) == 3 then
      return string.sub(word,utf8.offset(word,3))
   else
      return nil
   end
end

function lastCharacter(word)
   return string.sub(word,utf8.offset(word,-1))
end

function beginLowercase(word)
   local c = firstCharacter(word)
   local ch
   if c == "Ā" then ch = "ā"
   elseif c == "Ă" then ch = "ă"
   elseif c == "Á" then ch = "á"
   elseif c == "Æ" then ch = "æ"
   elseif c == "Ǣ" then ch = "ǣ"
   elseif c == "Ǽ" then ch = "ǽ"
   elseif c == "Ē" then ch = "ē"
   elseif c == "Ĕ" then ch = "ĕ"
   elseif c == "É" then ch = "é"
   elseif c == "Ī" then ch = "ī"
   elseif c == "Ĭ" then ch = "ĭ"
   elseif c == "Í" then ch = "í"
   elseif c == "Ō" then ch = "ō"
   elseif c == "Ŏ" then ch = "ŏ"
   elseif c == "Ó" then ch = "ó"
   elseif c == "Œ" then ch = "œ"
   elseif c == "Ū" then ch = "ū"
   elseif c == "Ŭ" then ch = "ŭ"
   elseif c == "Ú" then ch = "ú"
   elseif c == "Ȳ" then ch = "ȳ"
   elseif c == "Ý" then ch = "ý"
   else ch = string.lower(c) end
   return ch..string.sub(word,utf8.offset(word,2))
end

function contains_j(word)
   if string.find(word,"j") or string.find(word,"J") then
      return true
   else
      return false
   end
end

function contains_U_or_v(word) -- U/v are modern, V/u are classical
   if string.find(word,"v") or string.find(word,"U") or string.find(word,"Ū") then
      return true
   else
      return false
   end
end

function containsDigraph(word)
   if string.find(word,"Æ") or string.find(word,"æ") or string.find(word,"ǽ") or string.find(word,"Œ") or string.find(word,"œ") then
      return true
   else
      return false
   end
end

function containsDiphthong(word)
   if string.find(word,"Au") or string.find(word,"au") or string.find(word,"Eu") or string.find(word,"eu") then
      return true
   else
      return false
   end
end

function hasMoreThanOneSyllable(word)
   if string.find(word,"-") or string.find(word,"~") or string.find(word,"_") or string.find(word,"·") or string.find(word,"%.") then
      return true
   else
      return false
   end
end

function lastSyllableBoundary(word)
   local index
   for i, code in utf8.codes(word) do
      local c = utf8.char(code)
      if c == "-" or c == "~" or c == "_" or c == "·" or c == "." then
         index = i
      end
   end
   return index
end

function splitHead(word)
   local c1 = firstCharacter(word)
   local c2 = secondCharacter(word)
   local head -- Au, au, Áu, áu, Eu, eu, Éu, éu, Æ·, æ·, ·æ, Ǽ·, ǽ·, ·ǽ, Œ́, œ́, Œ·, œ·, ·œ, Œ́·, œ́·, ·œ́, accented macron vowel, ~j, Qu, qu, gu, Su, su, or a single character
   local tail

   if (c1 == "A" or c1 == "a" or c1 == "Á" or c1 == "á" or c1 == "E" or c1 == "e" or c1 == "É" or c1 == "é") and c2 == "u" then
      head = c1..c2
      if utf8.len(word) > 2 then
         tail = string.sub(word,utf8.offset(word,3))
      else
         tail = ""
      end
   elseif utf8.len(word) > 2 and (c1 == "Æ" or c1 == "æ" or c1 == "Ǽ" or c1 == "ǽ" or c1 == "Œ" or c1 == "œ") and c2 == "·" then
      head = c1..c2
      tail = string.sub(word,utf8.offset(word,3))
   elseif utf8.len(word) > 3 and (c1 == "Œ" or c1 == "œ") and c2 == combiningAcute and thirdCharacter(word) == "·" then
      head = c1..c2.."·"
      tail = string.sub(word,utf8.offset(word,4))
   elseif (c1 == "Œ" or c1 == "œ") and c2 == combiningAcute then
      head = c1..c2
      if utf8.len(word) > 2 then
         tail = string.sub(word,utf8.offset(word,3))
      else
         tail = ""
      end
   elseif c1 == "·" and (c2 == "æ" or c2 == "ǽ" or c2 == "œ") then
      head = c1..c2
      if utf8.len(word) > 2 then
         tail = string.sub(word,utf8.offset(word,3))
      else
         tail = ""
      end
   elseif utf8.len(word) > 2 and c1 == "·" and c2 == "œ" and thirdCharacter(word) == combiningAcute then
      head = c1..c2..combiningAcute
      if utf8.len(word) > 3 then
         tail = string.sub(word,utf8.offset(word,4))
      else
         tail = ""
      end
   elseif longVowels[c1] and c2 == combiningAcute then
      head = c1..c2
      tail = string.sub(word,utf8.offset(word,3))
   elseif (c1 == "~" or c1 == "_") and c2 == "j" then
      head = c1..c2
      tail = string.sub(word,3)
   elseif utf8.len(word) > 2 and (c1 == "Q" or c1 == "q") and c2 == "u" then
      head = c1..c2
      tail = string.sub(word,3)
   elseif utf8.len(word) > 2 and (c1 == "g" or c1 == "S" or c1 == "s") and c2 == "u" and vowels[thirdCharacter(word)] then
      head = c1..c2
      tail = string.sub(word,3)
   else
      head = c1
      if utf8.len(word) > 1 then
         tail = string.sub(word,utf8.offset(word,2))
      else
         tail = ""
      end
   end
   return head, tail
end

function beginsWithDoubleConsonant(syllable)
   local c1 = firstCharacter(syllable)
   local c2 = secondCharacter(syllable)
   local c3 = thirdCharacter(syllable)
   if c1 == "j" or c1 == "x" or c1 == "z" then
      return true
   elseif not lowercaseConsonants[c1] then
      return false
   elseif not lowercaseConsonants[c2] then
      return false
   elseif lowercaseMutae[c1] and lowercaseLiquidae[c2] then
      return false
   elseif lowercaseMutae[c1] and c2 == "h" and (not lowercaseConsonants[c3] or lowercaseLiquidae[c3]) then
      return false
   else
      return true
   end
end

function containsLongVowel(word)
   for _, code in utf8.codes(word) do
      if longVowels[utf8.char(code)] then
         return true
      end
   end

   return false
end

function containsShortVowel(word)
   while word ~= "" do
      c, word = splitHead(word)
      if shortVowels[c] then
         return true
      end
   end

   return false
end

function containsAccent(word)
   if string.find(word,combiningAcute) or string.find(word,"á") or string.find(word,"é") or string.find(word,"í")
   or string.find(word,"ó") or string.find(word,"ú") or string.find(word,"ý") or string.find(word,"ǽ") then
      return true
   else
      return false
   end
end

function removeAccent(word)
   local tmp = string.gsub(word,combiningAcute,"")
   tmp = string.gsub(tmp,"á","a")
   tmp = string.gsub(tmp,"é","e")
   tmp = string.gsub(tmp,"í","i")
   tmp = string.gsub(tmp,"ó","o")
   tmp = string.gsub(tmp,"ú","u")
   tmp = string.gsub(tmp,"ý","y")
   tmp = string.gsub(tmp,"ǽ","æ")
   return tmp
end

function addAccent(word)
   local i = lastSyllableBoundary(word)
   if hasMoreThanOneSyllable(string.sub(word,1,i-1)) then -- at least three syllables
      local j = lastSyllableBoundary(string.sub(word,1,i-1))
      if string.sub(word,i,i+1) == "·" then
         beginUltima = i+2
      else
         beginUltima = i+1
      end
      if string.sub(word,j,j+1) == "·" then
         beginPaenultima = j+2
      else
         beginPaenultima = j+1
      end
      endPaenultima = i-1
      local paenultima = string.sub(word,beginPaenultima,endPaenultima)
      local ultima = string.sub(word,beginUltima)
      if containsLongVowel(paenultima) or containsDigraph(paenultima) or containsDiphthong(paenultima)
      or lowercaseConsonants[lastCharacter(paenultima)] or beginsWithDoubleConsonant(ultima) then
         beginAccentedSyllable = beginPaenultima
         endAccentedSyllable = endPaenultima
      else
         if hasMoreThanOneSyllable(string.sub(word,1,j-1)) then -- at least four syllables
            local k = lastSyllableBoundary(string.sub(word,1,j-1))
            if string.sub(word,k,k+1) == "·" then
               beginAccentedSyllable = k+2
            else
               beginAccentedSyllable = k+1
            end
         else
            beginAccentedSyllable = 1
         end
         endAccentedSyllable = j-1
      end
   else
      beginAccentedSyllable = 1
      endAccentedSyllable = i-1
   end
   local output
   if beginAccentedSyllable > 1 then
      output = string.sub(word,1,beginAccentedSyllable-1)
   else
      output = ""
   end
   local accentedSyllable = string.sub(word,beginAccentedSyllable,endAccentedSyllable)
   while string.len(accentedSyllable) > 0 do
      local c, tail = splitHead(accentedSyllable)
      if c == "A" then
         output = output.."Á"
      elseif c == "a" then
         output = output.."á"
      elseif c == "E" then
         output = output.."É"
      elseif c == "e" then
         output = output.."é"
      elseif c == "I" then
         output = output.."Í"
      elseif c == "i" then
         output = output.."í"
      elseif c == "O" then
         output = output.."Ó"
      elseif c == "o" then
         output = output.."ó"
      elseif c == "U" then
         output = output.."Ú"
      elseif c == "u" then
         output = output.."ú"
      elseif c == "Y" then
         output = output.."Ý"
      elseif c == "y" then
         output = output.."ý"
      elseif c == "Æ" then
         output = output.."Ǽ"
      elseif c == "æ" then
         output = output.."ǽ"
      elseif c == "Au" then
         output = output.."Áu"
      elseif c == "au" then
         output = output.."áu"
      elseif c == "Eu" then
         output = output.."Éu"
      elseif c == "eu" then
         output = output.."éu"
      elseif c == "Œ" or c == "œ" or longVowels[c] then
         output = output..c..combiningAcute
      else
         output = output..c
      end
      accentedSyllable = tail
   end
   output = output..string.sub(word,endAccentedSyllable+1)
   return output
end

function insertVariants(list,character,endings)
   if next(endings) == nil then
      table.insert(list,character)
   else
      for _, ending in pairs(endings) do
         table.insert(list,character..ending)
      end
   end
end

function insertDiphthongVariants(list,firstLetter,secondLetter,endingVariants,diphthongType)
   if diphthongType == "plain" or mixedDiacritics then
      insertVariants(list,firstLetter..secondLetter,endingVariants)
   end
   if diphthongType == "tie" or (mixedDiacritics and createTieVariants) then
      if firstLetter == "Á" then
         insertVariants(list,"A"..combiningTie..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "á" then
         insertVariants(list,"a"..combiningTie..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "-á" then
         insertVariants(list,"-a"..combiningTie..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "Ó" then
         insertVariants(list,"O"..combiningTie..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "ó" then
         insertVariants(list,"o"..combiningTie..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "-ó" then
         insertVariants(list,"-o"..combiningTie..combiningAcute..secondLetter,endingVariants)
      else
         insertVariants(list,firstLetter..combiningTie..secondLetter,endingVariants)
      end
   end
   if diphthongType == "macron" or (mixedDiacritics and createMacronVariants) then
      if firstLetter == "Á" then
         insertVariants(list,"A"..combiningDoubleMacron..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "á" then
         insertVariants(list,"a"..combiningDoubleMacron..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "Ó" then
         insertVariants(list,"O"..combiningDoubleMacron..combiningAcute..secondLetter,endingVariants)
      elseif firstLetter == "ó" then
         insertVariants(list,"o"..combiningDoubleMacron..combiningAcute..secondLetter,endingVariants)
      else
         insertVariants(list,firstLetter..combiningDoubleMacron..secondLetter,endingVariants)
      end
   end
end

function insertDigraphVariants(list,digraph,firstLetter,secondLetter,endingVariants,useDigraphs,digraphType,diphthongType)
   if useDigraphs then
      if digraphType == "plain" or mixedDiacritics then
         insertVariants(list,digraph,endingVariants)
      end
      if digraphType == "macron" or (mixedDiacritics and createMacronVariants) then
         if digraph == "Æ" then
            insertVariants(list,"Ǣ",endingVariants)
         elseif digraph == "æ" then
            insertVariants(list,"ǣ",endingVariants)
         elseif digraph == "Ǽ" then
            insertVariants(list,"Ǣ"..combiningAcute,endingVariants)
         elseif digraph == "ǽ" then
            insertVariants(list,"ǣ"..combiningAcute,endingVariants)
         elseif digraph == "Œ́" then
            insertVariants(list,"Œ"..combiningMacron..combiningAcute,endingVariants)
         elseif digraph == "œ́" then
            insertVariants(list,"œ"..combiningMacron..combiningAcute,endingVariants)
         else
            insertVariants(list,digraph..combiningMacron,endingVariants)
         end
      end
   else
      insertDiphthongVariants(list,firstLetter,secondLetter,endingVariants,diphthongType)
   end
end

function createVariants(word,use_j,use_Uv,useDigraphs,useMacrons,useBreves,digraphType,diphthongType)
   local listOfVariants = {}

   if utf8.len(word) >= 1 then
      local c, ending = splitHead(word)
      local endingVariants = createVariants(ending,use_j,use_Uv,useDigraphs,useMacrons,useBreves,digraphType,diphthongType)

      if longVowels[firstCharacter(c)] then
         -- variant without macron
         if not useMacrons or mixedDiacritics then
            if c == "Ā" then ch = "A"
            elseif c == "ā" then ch = "a"
            elseif c == "Ē" then ch = "E"
            elseif c == "ē" then ch = "e"
            elseif c == "Ī" then ch = "I"
            elseif c == "ī" then ch = "i"
            elseif c == "Ō" then ch = "O"
            elseif c == "ō" then ch = "o"
            elseif c == "Ū" then if use_Uv then ch = "U" else ch = "V" end
            elseif c == "ū" then ch = "u"
            elseif c == "Ȳ" then ch = "Y"
            elseif c == "ȳ" then ch = "y"
            elseif c == "Ā"..combiningAcute then ch = "Á"
            elseif c == "ā"..combiningAcute then ch = "á"
            elseif c == "Ē"..combiningAcute then ch = "É"
            elseif c == "ē"..combiningAcute then ch = "é"
            elseif c == "Ī"..combiningAcute then ch = "Í"
            elseif c == "ī"..combiningAcute then ch = "í"
            elseif c == "Ō"..combiningAcute then ch = "Ó"
            elseif c == "ō"..combiningAcute then ch = "ó"
            elseif c == "Ū"..combiningAcute then if use_Uv then ch = "Ú" else ch = "V́" end
            elseif c == "ū"..combiningAcute then ch = "ú"
            elseif c == "Ȳ"..combiningAcute then ch = "Ý"
            elseif c == "ȳ"..combiningAcute then ch = "ý"
            end
            insertVariants(listOfVariants,ch,endingVariants)
         end
         -- variant with macron
         if useMacrons then
            if c == "Ū" and not use_Uv then
               ch = "V̄"
            else
               ch = c
            end
            insertVariants(listOfVariants,ch,endingVariants)
         end
      elseif shortVowels[c] then
         -- variant without breve
         if not useBreves or mixedDiacritics or mixedBreves then
            if c == "U" and not use_Uv then
               ch = "V"
            else
               ch = c
            end
            insertVariants(listOfVariants,ch,endingVariants)
         end
         -- variant with breve
         if useBreves then
            if c == "A" then ch = "Ă"
            elseif c == "a" then ch = "ă"
            elseif c == "E" then ch = "Ĕ"
            elseif c == "e" then ch = "ĕ"
            elseif c == "I" then ch = "Ĭ"
            elseif c == "i" then ch = "ĭ"
            elseif c == "O" then ch = "Ŏ"
            elseif c == "o" then ch = "ŏ"
            elseif c == "U" then if use_Uv then ch = "Ŭ" else ch = "V̆" end
            elseif c == "u" then ch = "ŭ"
            elseif c == "Y" then ch = "Y̆"
            elseif c == "y" then ch = "y̆"
            elseif c == "Á" then ch = "Ă"..combiningAcute 
            elseif c == "á" then ch = "ă"..combiningAcute
            elseif c == "É" then ch = "Ĕ"..combiningAcute
            elseif c == "é" then ch = "ĕ"..combiningAcute
            elseif c == "Í" then ch = "Ĭ"..combiningAcute
            elseif c == "í" then ch = "ĭ"..combiningAcute
            elseif c == "Ó" then ch = "Ŏ"..combiningAcute
            elseif c == "ó" then ch = "ŏ"..combiningAcute
            elseif c == "Ú" then if use_Uv then ch = "Ŭ"..combiningAcute else ch = "V̆"..combiningAcute end
            elseif c == "ú" then ch = "ŭ"..combiningAcute
            elseif c == "Ý" then ch = "Y̆"..combiningAcute
            elseif c == "ý" then ch = "y̆"..combiningAcute
            end
            insertVariants(listOfVariants,ch,endingVariants)
         end
      elseif c == "Æ" then
         insertDigraphVariants(listOfVariants,"Æ","A","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "æ" then
         insertDigraphVariants(listOfVariants,"æ","a","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Ǽ" then
         insertDigraphVariants(listOfVariants,"Ǽ","Á","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "ǽ" then
         insertDigraphVariants(listOfVariants,"ǽ","á","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Æ·" then
         insertDigraphVariants(listOfVariants,"Æ","A","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "æ·" then
         insertDigraphVariants(listOfVariants,"æ","a","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Ǽ·" then
         insertDigraphVariants(listOfVariants,"Ǽ","Á","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "ǽ·" then
         insertDigraphVariants(listOfVariants,"ǽ","á","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "·æ" then
         insertDigraphVariants(listOfVariants,"æ","-a","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "·ǽ" then
         insertDigraphVariants(listOfVariants,"ǽ","-á","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Œ" then
         insertDigraphVariants(listOfVariants,"Œ","O","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "œ" then
         insertDigraphVariants(listOfVariants,"œ","o","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Œ́" then
         insertDigraphVariants(listOfVariants,"Œ́","Ó","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "œ́" then
         insertDigraphVariants(listOfVariants,"œ́","ó","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Œ·" then
         insertDigraphVariants(listOfVariants,"Œ","O","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "œ·" then
         insertDigraphVariants(listOfVariants,"œ","o","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Œ́·" then
         insertDigraphVariants(listOfVariants,"Œ́","Ó","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "œ́·" then
         insertDigraphVariants(listOfVariants,"œ́","ó","e-",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "·œ" then
         insertDigraphVariants(listOfVariants,"œ","-o","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "·œ́" then
         insertDigraphVariants(listOfVariants,"œ́","-ó","e",endingVariants,useDigraphs,digraphType,diphthongType)
      elseif c == "Au" then
         insertDiphthongVariants(listOfVariants,"A","u",endingVariants,diphthongType)
      elseif c == "au" then
         insertDiphthongVariants(listOfVariants,"a","u",endingVariants,diphthongType)
      elseif c == "Áu" then
         insertDiphthongVariants(listOfVariants,"Á","u",endingVariants,diphthongType)
      elseif c == "áu" then
         insertDiphthongVariants(listOfVariants,"á","u",endingVariants,diphthongType)
      elseif c == "Eu" then
         insertDiphthongVariants(listOfVariants,"E","u",endingVariants,diphthongType)
      elseif c == "eu" then
         insertDiphthongVariants(listOfVariants,"e","u",endingVariants,diphthongType)
      elseif c == "Éu" then
         insertDiphthongVariants(listOfVariants,"É","u",endingVariants,diphthongType)
      elseif c == "éu" then
         insertDiphthongVariants(listOfVariants,"é","u",endingVariants,diphthongType)
      elseif c == "J" then
         if use_j then
            insertVariants(listOfVariants,"J",endingVariants)
         else
            insertVariants(listOfVariants,"I",endingVariants)
         end
      elseif c == "j" then
         if use_j then
            insertVariants(listOfVariants,"j",endingVariants)
         else
            insertVariants(listOfVariants,"i",endingVariants)
         end
      elseif c == "~j" then
         if use_j then
            insertVariants(listOfVariants,"-j",endingVariants)
         else
            insertVariants(listOfVariants,"-",endingVariants)
         end
      elseif c == "_j" then
         if use_j then
            insertVariants(listOfVariants,"j",endingVariants)
         else
            insertVariants(listOfVariants,"",endingVariants)
         end
      elseif c == "·" then
         if use_j then
            insertVariants(listOfVariants,"-",endingVariants)
         else
            insertVariants(listOfVariants,"",endingVariants)
         end
      elseif c == "v" then
         if use_Uv then
            insertVariants(listOfVariants,"v",endingVariants)
         else
            insertVariants(listOfVariants,"u",endingVariants)
         end
      elseif c == "." then -- syllable boundary that is no hyphenation point
         insertVariants(listOfVariants,"",endingVariants)
      else
         insertVariants(listOfVariants,c,endingVariants)
      end
   end

   return listOfVariants
end

function addOutputForm(word)
   if outputNon_ec_AccentVariants or (not string.find(word,combiningAcute) and not string.find(word,"Ǽ") and not string.find(word,"ǽ")) then
      local key = beginLowercase(string.gsub(word,"-",""))
      if outputList[key] == nil then
         outputList[key] = word
         commentList[key] = comment
      elseif beginLowercase(outputList[key]) ~= beginLowercase(word) then
         local synthesis = ""
         local offset = 0
         local rejected1 = ""
         local rejected2 = ""
         local index = 1
         while index <= string.len(outputList[key]) do
            local c1 = string.sub(outputList[key],index,index)
            local c2 = string.sub(word,index+offset,index+offset)
            if c1 == "-" and c2 ~= "-" then
               offset = offset-1
               rejected1 = rejected1..c1
            elseif c1 ~= "-" and c2 == "-" then
               offset = offset+1
               rejected2 = rejected2..c2
               index = index-1
            else
               synthesis = synthesis..c1
               if c1 ~= "-" then
                  rejected1 = rejected1..c1
                  rejected2 = rejected2..c2
               end
            end
            index = index+1
         end
         if string.find(rejected1,"-") then
            if not rejectedHyphenations[rejected1] then
               rejectedHyphenations[rejected1] = true
               logFile:write("rejected hyphenation: "..rejected1.." < "..commentList[key].."\n")
            end
         end
         if string.find(rejected2,"-") then
            if not rejectedHyphenations[rejected2] then
               rejectedHyphenations[rejected2] = true
               logFile:write("rejected hyphenation: "..rejected2.." < "..comment.."\n")
            end
         end
         outputList[key] = synthesis
         commentList[key] = commentList[key].."/"..comment
      elseif commentList[key] ~= comment then
         commentList[key] = commentList[key].."/"..comment
      end
   end
end

function addVariantsToOutput(word,use_j,use_Uv,useDigraphs,useMacrons,useBreves,digraphType,diphthongType)
   for _, word in pairs(createVariants(word,use_j,use_Uv,useDigraphs,useMacrons,useBreves,digraphType,diphthongType)) do
      if utf8.len(word) >= 2 then
         addOutputForm(word)
      end
   end
end

romanSymbols = {"I","V","X","L","C","D","M"}
romanValues = {1,5,10,50,100,500,1000}

function romanNumeral(number)
   local roman = ""
   for i = 7, 1, -1 do
      while number-romanValues[i] >= 0 do
         roman = roman..romanSymbols[i]
         number = number-romanValues[i]
      end
      if (i == 7 or i == 6) and number-romanValues[i] >= -100 then
         roman = roman..romanSymbols[5]..romanSymbols[i]
         number = number-romanValues[i]+100
      elseif (i == 5 or i == 4) and number-romanValues[i] >= -10 then
         roman = roman..romanSymbols[3]..romanSymbols[i]
         number = number-romanValues[i]+10
      elseif (i == 3 or i == 2) and number-romanValues[i] == -1 then
         roman = roman..romanSymbols[1]..romanSymbols[i]
         number = number-romanValues[i]+1
      end
   end
   return roman
end

create_j_variants = true
create_v_variants = true
createDigraphVariants = true
createMacronVariants = true
createBreveVariants = true
createTieVariants = true
createAccentVariants = true
outputNon_ec_AccentVariants = true
mixedDiacritics = false
mixedBreves = false

-- read arguments from command line
i = 1
while arg[i] do
   if arg[i] == "--no-j" then
      create_j_variants = false
   elseif arg[i] == "--no-v" then
      create_v_variants = false
   elseif arg[i] == "--no-digraphs" then
      createDigraphVariants = false
   elseif arg[i] == "--no-macrons" then
      createMacronVariants = false
   elseif arg[i] == "--no-breves" then
      createBreveVariants = false
   elseif arg[i] == "--no-ties" then
      createTieVariants = false
   elseif arg[i] == "--no-accents" then
      createAccentVariants = false
   elseif arg[i] == "--ec" then
      createMacronVariants = false
      createBreveVariants = false
      createTieVariants = false
      outputNon_ec_AccentVariants = false
   elseif arg[i] == "--mixed" then
      mixedDiacritics = true
   elseif arg[i] == "--mixed-breves" then
      mixedBreves = true
   elseif arg[i] == "--roman-numerals" then
      local numeral
      for k = 1, 3000 do
         numeral = romanNumeral(k)
         if string.len(numeral) > 1 then
            addOutputForm(numeral)
            if string.sub(numeral,-1) == "I" then
               addOutputForm(string.sub(numeral,1,-2).."J") -- spelling variant
            end
         end
      end
   else
      error('Invalid argument "'..arg[i]..'".')
   end
   i = i+1
end

-- read input line by line
linecount = 0
for line in io.lines() do
   linecount = linecount + 1
   local i = string.find(line," < ")
   if i then
      word = string.sub(line,1,i-1)
      comment = string.sub(line,i+3)
   else
      word = line
      comment = ""
   end
   for j_index = 0, 1 do
      if j_index == 0 or (create_j_variants and contains_j(word)) then
         for v_index = 0, 1 do
            if v_index == 0 or (create_v_variants and contains_U_or_v(word)) then
               for digraphIndex = 0, 1 do
                  if digraphIndex == 0 or (createDigraphVariants and containsDigraph(word)) then
                     local use_j = j_index > 0
                     local use_Uv = v_index > 0
                     local useDigraphs = digraphIndex > 0
                     for accentIndex = 0, 1 do
                        if accentIndex == 0 or (createAccentVariants and hasMoreThanOneSyllable(word,useDigraphs)) then
                           if accentIndex == 0 then
                              if containsAccent(word) then
                                 preparedWord = removeAccent(word)
                              else
                                 preparedWord = word
                              end
                           else
                              if containsAccent(word) then
                                 preparedWord = word
                              else
                                 preparedWord = addAccent(word)
                              end
                           end
                           if mixedDiacritics then
                              addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,createMacronVariants,createBreveVariants,"","")
                           else
                              -- (1) variant without macrons and breves
                              if containsLongVowel(word) or not mixedBreves then
                                 addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,false,false,"plain","plain")
                                 -- (2) variant with ties on diphthongs, but without macrons and breves
                                 if createTieVariants and ((not useDigraphs and containsDigraph(word)) or containsDiphthong(word)) then
                                    addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,false,false,"plain","tie")
                                 end
                              end
                              -- (3) variant with macrons, but without breves
                              if createMacronVariants and containsLongVowel(word) and not mixedBreves then
                                 addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,true,false,"plain","plain")
                                 -- (4) variant with macrons and with ties on diphthongs, but without breves
                                 if createTieVariants and ((not useDigraphs and containsDigraph(word)) or containsDiphthong(word)) then
                                    addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,true,false,"plain","tie")
                                 end
                              end
                              -- (5) variant with macrons even on digraphs, but without breves
                              if createMacronVariants and not mixedBreves and useDigraphs then
                                 addVariantsToOutput(preparedWord,use_j,use_Uv,true,true,false,"macron","plain")
                              end
                              -- (6) variant with macrons even on digraphs and diphthongs, but without breves
                              if createMacronVariants and not mixedBreves
                              and ((not useDigraphs and containsDigraph(word)) or containsDiphthong(word)) then
                                 addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,true,false,"macron","macron")
                              end
                              if createBreveVariants and containsShortVowel(word) then
                                 -- (7) variant with (macrons and) breves
                                 addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,createMacronVariants,true,"plain","plain")
                                 -- (8) variant with (macrons and) breves and with ties on diphthongs
                                 if createTieVariants and ((not useDigraphs and containsDigraph(word)) or containsDiphthong(word)) then
                                    addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,true,true,"plain","tie")
                                 end
                                 -- (9) variant with macrons even on digraphs and with breves
                                 if createMacronVariants and useDigraphs then
                                    addVariantsToOutput(preparedWord,use_j,use_Uv,true,true,true,"macron","plain")
                                 end
                                 -- (10) variant with macrons even on digraphs and diphthongs and with breves
                                 if createMacronVariants and ((not useDigraphs and containsDigraph(word)) or containsDiphthong(word)) then
                                    addVariantsToOutput(preparedWord,use_j,use_Uv,useDigraphs,true,true,"macron","macron")
                                 end
                              end
                           end
                        end
                     end
                  end
               end
            end
         end
      end
   end
end

for _, word in pairs(outputList) do
   print(word)
end
