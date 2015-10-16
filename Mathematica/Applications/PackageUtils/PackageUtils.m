(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



BeginPackage["PackageUtils`"];

ShowStatus::usage="Prints the message in the status bar";
EmbedNote::usage="Embedes cells with tag from a notebook located at path";
DuplicateNotebook::usage="Makes a copy of the notebook";
PrintToConsole::usage="Send to console";
MergeExport::usage ="Merges stylesheet with the notebook and saves in the same directory with the postfix _sm";
CodeVisible::usage = "Shows/Hides code and cell tags";PublishToPDF::usage="Saves a publishing ready version, optional argument for copy (pendrive)";
CreateTOC::usage="Create table of contents";
StyleButton::usage="Creates a button to create a style Cell of a specific name";
WordStats::usage="Prints current notebook word/character stats in Status area";
Begin["`Private`"];

DuplicateNotebook[]:=NotebookPut@NotebookGet[EvaluationNotebook[]];

PrintToConsole[expr_]:=(SetSelectedNotebook[MessagesNotebook[]];
NotebookWrite[SelectedNotebook[],Cell[BoxData[ToBoxes[expr]],"Print"]]);

ShowStatus[status_]:=LinkWrite[$ParentLink,SetNotebookStatusLine[FrontEnd`EvaluationNotebook[],ToString[status]]];

StyleButton[name_]:=Button[name,SelectionMove[SelectedNotebook[],All,Cell];FrontEndExecute@FrontEndToken[SelectedNotebook[],"Style",name]];

EmbedNote[notebookpath_,tag_]:=Block[{m},
Catch[
NotebookWrite[
EvaluationNotebook[],
Cell[CellGroupData[
Cases[First@Get[If[(m=FindFile[notebookpath])=!=$Failed,m,Throw["File \""<> notebookpath <>"\" not found"]]],Cell[__,CellTags->(tag|{___,tag,___}),___],\[Infinity]]],CellFrame->{{0,0},{0,0}},CellDingbat->ButtonBox[StyleBox["\[LeftAngleBracket]","Dingbat"],Appearance->"Frameless",Tooltip->notebookpath,ButtonFunction->(NotebookLocate[#]&),ButtonData->{m,tag}]
]
]
]
];
WordStats[]:=
Module[{dat,data,characters,words},
cells=Cells[EvaluationNotebook[],CellStyle->{"Title","Section","Subsection","Subsubsection","Subsubsubection","Text","EquationNumbered","Equation","Item1","Item2","Item3","Item1Numbered","Item2Numbered","Item3Numbered"}];
data=NotebookRead@cells;
dat=ReplaceRepeated[data,
{
RowBox[{C__String}]:>StringJoin@C,
StyleBox[D__,Background->None]:>StyleBox[D],
StyleBox[D_String]:>D,
Cell[TextData[data_],___]:> data,
Cell[BoxData[data_],___]:> data,
Cell[data_,___]:> data,
Cell[BoxData[data_],___]:> data,
FormBox[C_String,TextForm|TraditionalForm]:> C
}];
dat=Block[{n=1},ReplaceAll[dat,{
(FormBox[RowBox[{C__String}],TextForm]|FormBox[RowBox[{C__String}],TraditionalForm]):>StringJoin@C,
(FormBox[C__, TraditionalForm]|FormBox[C__, TextForm]):>"[$]"<>Convert`TeX`BoxesToTeX[C, "BoxRules"->{StyleBox[D_,Background->LightGreen]:> "[/$]{{c"<>ToString[n]<>"::[$]" <>StringReplace[Convert`TeX`BoxesToTeX [D],{"{{":> " { { ","}}":> " } } "}] <>"[/$]}}[$]"}]<>"[/$] ",

StyleBox[D_, Background->LightGreen]:>("{{c"<>ToString[n]<>"::"<>D<>"}}"),
StyleBox[D_String,___,FontWeight->"Bold",___]:> D,
StyleBox[D_String,___,FontSlant->"Italic",___]:> D,
StyleBox[D_String,___,FontWeight->"Plain",___]:> D,
StyleBox[D_String,___,FontVariations->{___,"Underline"->True,___},___]:> (D),
StyleBox[D_String,___,FontVariations->__,___]:> D,
StyleBox[D_, Background->_]:>ToString[n],
ButtonBox[RowBox[{_,CounterBox[_,N_],_}],___]:> (Convert`TeX`BoxesToTeX@First@Cases[data,Cell[name_,___,CellTags->N,___]:>name,Infinity]),
ButtonBox[RowBox[{_,CounterBox[_],_}],___]:> "",
CounterBox["FigureCaptionNumbered",N_]:> "",
CounterBox["FigureCaptionNumbered"]:> "",
ButtonBox[___]:> ""
}]];
words=ToString@Total[WordCount[#]&/@Flatten[dat]];
characters=ToString@Total[StringLength[#]&/@Flatten[dat]];
ShowStatus["Counted: "<>characters<>" characters (with spaces) and " <> words<> " words"];
];


MergeExport[]:=Module[{path,child,childstyles,parent,nb,tmp,parentparent,parentstyles, old},(*find the parent stylesheet from the private stylesheet,a.k.a child*)
If[NotebookDirectory[]===$Failed, Abort[]];
path=ToFileName[{$UserBaseDirectory,"SystemFiles","FrontEnd","StyleSheets"}];
child=Options[EvaluationNotebook[],StyleDefinitions];
parent=First@Cases[Options[EvaluationNotebook[],StyleDefinitions],(StyleDefinitions-> x_):>x,\[Infinity]] ;
childstyles=Cases[child,Cell[StyleData[_,___],__],\[Infinity]];
(*get the parent*)
nb=NotebookOpen[path<>parent];
tmp=NotebookGet[nb];
NotebookClose[nb];
(*find the parent definition*)parentparent=Cases[tmp,Cell[StyleData[StyleDefinitions->x_]],\[Infinity]];
(*scrape the styles*)parentstyles=Cases[tmp,Cell[StyleData[x_,y___],z__],\[Infinity]];
(*merge parents parent,child styles,parent styles*)SetOptions[EvaluationNotebook[],StyleDefinitions->Notebook[Join[parentparent,childstyles,parentstyles],StyleDefinitions->"PrivateStylesheetFormatting.nb"],DockedCells->None];

old=FileBaseName[NotebookFileName[]];
NotebookSave[EvaluationNotebook[],NotebookDirectory[EvaluationNotebook[]]<>old<>"_sm.nb"];
NotebookOpen[NotebookDirectory[EvaluationNotebook[]]<>old<>".nb"];
];

CodeVisible[] := Module[{cells,show},
   cells = Cells[EvaluationNotebook[], CellStyle -> "Input"];
show=Last@First@Options[EvaluationNotebook[],ShowCellTags];

SetOptions[EvaluationNotebook[],ShowCellLabel->!show];
SetOptions[EvaluationNotebook[],ShowCellTags->!show];
   Map[SetOptions[#, CellOpen -> !show] &, cells];
   ];

CreateTOC[typeList_]:=Module[{toc,book,createCell,counter,cell,type,tag,tocreate,sel},
sel=False;
If[SelectedCells[]=={},
NotebookWrite[EvaluationNotebook[],Cell["Temp","Subtitle",CellTags->"TempIndex"]];
sel=True;
];
If[sel==False, Return];
tocreate={};
book=EvaluationNotebook[];
SetOptions[book,ShowPageBreaks->True];
(*helper file for creating cell*)createCell[text_,tag_,level_]:={"",DynamicBox@Refresh[StringJoin[Table["\t",{i,1,level-1}]]<>(NotebookRead[Cells[EvaluationNotebook[],CellTags->tag]][[1]]/.{Cell[t_,___]:>t}),UpdateInterval->1],DynamicBox@CounterBox["Page",tag]};
(*iterate over cells to set tags and write lines to TOC*)Scan[(counter[#]=0)&,typeList];
SelectionMove[book,Next,Cell];
While[(cell=NotebookRead[book])=!={},If[Length[cell]>=2,type=cell[[2]];
If[MemberQ[typeList,type],counter[type]+=1;
tag=type<>ToString[counter[type]];
SetOptions[NotebookSelection[book],CellTags->tag];
SelectionMove[book,All,CellContents];
AppendTo[tocreate, createCell[SelectedCells[],tag,Position[typeList,type][[1,1]]]]];
SelectionMove[book,Next,Cell]];
];
If[sel,
NotebookLocate["Index"];
If[SelectedCells[]!={},
NotebookWrite[EvaluationNotebook[],Cell[BoxData[StyleBox[DynamicBox@GridBox[tocreate,GridBoxAlignment->{"Columns"->{Left,Left,Right}},GridBoxItemSize->{"Columns"->{1,32,-5}}],"Text"]],CellTags->"Index"]];
NotebookLocate["TempIndex"];
NotebookDelete[];,

NotebookLocate["TempIndex"];
NotebookDelete[];
NotebookWrite[EvaluationNotebook[],Cell[BoxData[StyleBox[DynamicBox@GridBox[tocreate,GridBoxAlignment->{"Columns"->{Left,Left,Right}},GridBoxItemSize->{"Columns"->{2 -1,35-2,-5}}],"Text"]],CellTags->"Index"]];
];
];
];

PublishToPDF[copyPath_: ""] := Module[{nb, nb2},
  nb = ToFileName[{NotebookDirectory[EvaluationNotebook[]]}, "WindowTitle" /. NotebookInformation[SelectedNotebook[]]];
  CodeVisible[False];
  Export[ nb <> ".pdf", SelectedNotebook[]];
  nb2 = copyPath <> ToString["WindowTitle" /. NotebookInformation[SelectedNotebook[]]] <> ".pdf";
  If[copyPath != "", CopyFile[nb <> ".pdf", nb2]];
  CodeVisible[True];
  {nb, nb2}
  ]


End[];
EndPackage[];
