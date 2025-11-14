\header {
  title = "Hacia dónde"
  subtitle = "2da estrofa"
}

\score {
  <<
    % 1. The Chords
    \new ChordNames {
      \chordmode {
        d1:13
        cis1:m7
        cis1:7
        % Corrected: Changed f to fis (F#) and added inversion for playback accuracy
        fis1:maj7.9/ais 
        a2:maj7
        b:7sus2
        e:maj7 
        a:maj7
      }
    }

    % 2. The Melody
    \new Staff \with {
      \consists "Span_arpeggio_engraver"
    }
    {
      \key cis \minor
      \relative c' {
        d8 fis c' b <d, fis c' b>2\arpeggio
        cis,8 gis' b e <cis, gis' b e>2\arpeggio
        cis8 f b cis <cis, f b cis>2\arpeggio
        % Note: bes is A# (the 3rd of F# major)
        bes8 fis' cis' aes f'2

        \break

        <a,, aes''>8 e' <a cis>4 
        <b, fis''>8 e <a cis>4
        <e, ees''>8 gis' 4 e' 
        <a,, e aes' cis>2\arpeggio
      }
    }

    % 3. The Roman Numeral Analysis
    \new Lyrics \with {
      \override VerticalAxisGroup.nonstaff-relatedstaff-spacing.padding = #1.5
    } \lyricmode {
      
      % Bar 1: Neapolitan
      \markup { \flat II \super 13 } 1          
      
      % Bar 2: Tonic
      \markup { i \super 7 } 1                  
      
      % Bar 3: Secondary Dominant
      \markup { V \super 7 / iv } 1             
      
      % Bar 4: IV Major 7 (Picardy/Borrowed) in 1st inversion
      % We use 6/5 to indicate a 7th chord in 1st inversion
      \markup { IV \super \raise #1 \small {6/5} } 1      
      
      % Bar 5: VI
      \markup { VI \super {maj7} } 2
      
      % Bar 5b: B is VII in C#m (or V of the relative Major)
      % Corrected from IV to VII. Added sus2.
      \markup { \flat VII \super {7sus2} } 2  
      
      % Bar 6: III (Relative Major Tonic)
      \markup { III \super {maj7} } 2 
      
      % Bar 6b: VI
      \markup { VI \super {maj7} } 2 
    }
  >>
  \layout { }
  \midi { }
}
