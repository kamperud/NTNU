%Cooperated with janalexa

\insert 'List.oz'
\insert 'Find.oz'
\insert 'FewFind.oz'
\insert 'FewerFind.oz'
\insert 'Visualizer.oz'
\insert 'Compress.oz'

fun{Move Main Track N}
   local X Y Z in
      if N > 0 then
	 X = {Drop Main {Length Main}-N}
	 Y = {Take Main {Length Main}-N}
	 Z = {Append X Track}
      else
	 X = {Take Track {Number.abs N}}
	 Y = {Append Main X}
	 Z = {Drop Track {Number.abs N}}
      end
      {Ozcar.breakpoint}
      [Y Z]
   end
end

fun{ApplyMoves State Moves}
   case Moves of nil then
      State|nil
   [] M|Mr then
      local S1 Res in
      S1 = case M of trackA(N) then
	 Res = {Move State.main State.trackA N}
	 state(main:Res.1 trackA:Res.2.1 trackB:State.trackB)     
      [] trackB(N) then
	 Res = {Move State.main State.trackB N}
	 state(main:Res.1 trackA:State.trackA trackB:Res.2.1)
	   end
	 State|{ApplyMoves S1 Mr}
      end
   end
end


declare
St = state(main:[a b] trackA:nil trackB:nil)
S = state(main:[c a b] trackA:nil trackB:nil)
F1 = {FewFind [c a b] [c b a]}
F2 = {FewerFind [c a b] nil nil [c b a ]}
Mv = [trackA(1) trackB(1) trackA(~1)]
{Browse {Find [c a b] [c b a]}}
{Browse F1}
{Browse F2}
{Browse {ApplyMoves St Mv}}
{Browse {Compress F1}}
