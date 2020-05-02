awk '
{
  for(i=1;i<=NF;i++){
    if($i<3)                   {  col[i]++ };
    if($i>5)                   {  col1[i]++}}
}
END{
  for(j in col){
    if(col[j]>=1 && col1[j]>=1){  print j  }}
}'  a
