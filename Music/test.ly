
\header{
  title = "Test"
  subtitle = "Subtitle"
}


\score{



<<
%  \chords { e2:maj7  fis2:m  gis2:m  a2:maj7 g:5-.6- fis2:m b:7 a4:dim gis4:dim
%    \break
%  f2:min c:69
%  }
\new StaffA\key e major \relative {
  \key e \major
  b2 ~ b8 cis dis e
  fis e fis e 
  fis e fis e 
  fis e fis e 
  fis e fis e 
  fis e fis cis 
  e4 dis r2 

  \break

  cis8 dis e fis
  gis fis gis fis
  gis fis gis fis
  gis fis gis fis
  gis fis gis fis
  gis fis gis e
  dis fis e

  dis8 e fis gis
  a gis a gis    % moving up to A natural
  a gis a gis
  a gis a gis
  a gis a gis
  a gis a fis    % The variation transposed
  a4 gis r2
}
>>
\layout { }
\midi { }
}
