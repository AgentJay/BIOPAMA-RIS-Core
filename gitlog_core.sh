#/bin/bash
# This script generates the log files for the 3 different repos used by BIOPAMA 
# Since the output is in markdown format we use <br/> to make a new line
# James Davy - 30/08/2019
thisdate=$(date +'%Y-%m-%d');
thisyear=$(date +'%Y');
thismonthname=$(date +'%B');
repocore="/var/www/vhosts/biopama.org/testalpha.biopama.org";
repotheme="/var/www/vhosts/biopama.org/testalpha.biopama.org/web/themes/custom/bootstrap_barrio_biopama";
repomodule="/var/www/vhosts/biopama.org/testalpha.biopama.org/web/modules/custom/biopama_form_hooks";
thistitle=$thisyear' - '$thismonthname;
header='---\ntitle: '$thistitle'\nauthor: James Davy\nlayout: post\n--- \n';
footer='</ul></details>\n';

echo -e '<details><summary>BIOPAMA Core</summary>\n\n<ul>' > $repocore/change_logs/core/$thisdate.md;
git --git-dir=$repocore/.git log \
--since='last month' \
--date=format:'%m-%d' \
--pretty=format:'<li>%ad - %an - %s' >> $repocore/change_logs/core/$thisdate.md;
echo -e $footer >> $repocore/change_logs/core/$thisdate.md;

echo -e '<details><summary>Theme</summary>\n\n<ul>' > $repocore/change_logs/theme/$thisdate.md;
git --git-dir=$repotheme/.git log \
--since='last month' \
--date=format:'%m-%d' \
--pretty=format:'<li>%ad - %an - %s' >> $repocore/change_logs/theme/$thisdate.md;
echo -e $footer >> $repocore/change_logs/theme/$thisdate.md;

echo -e '<details><summary>Module</summary>\n\n<ul>' > $repocore/change_logs/module/$thisdate.md;
git --git-dir=$repomodule/.git log \
--since='last month' \
--date=format:'%m-%d' \
--pretty=format:'<li>%ad - %an - %s' >> $repocore/change_logs/module/$thisdate.md;
echo -e $footer >> $repocore/change_logs/module/$thisdate.md;

echo -e $header > $repocore/_posts/$thisdate-$thismonthname-Changes.md;
cat $repocore/change_logs/core/$thisdate.md \
$repocore/change_logs/theme/$thisdate.md \
$repocore/change_logs/module/$thisdate.md \
>> $repocore/_posts/$thisdate-$thismonthname-Changes.md;

#I replace my Github user name with my real name since not many people in the project know my username
sed -i 's/AgentJay/James Davy/g' $repocore/_posts/$thisdate-$thismonthname-Changes.md;