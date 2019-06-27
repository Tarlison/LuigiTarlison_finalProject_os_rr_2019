# LuigiTarlison_finalProject_os_rr_2019
Repositório do Projeto Final da disciplina de Sistemas Operacionais 2019.1

Deixando a pasta pronta com os arquivos:

	1) Para compilar os arquivos é necessário fazer o git clone do repositório https://github.com/rhexsel/cmips na pasta /home/(seu usuário);		
    2) Pegue os arquivos da pasta '/tests' em nosso repositório e transfira para a pasta /cmips/cMIPS/tests no repositório cmips;
    3) Pegue os arquivos da pasta '/sav' em nosso repositório e transfira para a pasta /cmips/cMIPS no repositório cmips.

Instalando crossCompiler (caso necessário):

    1) Os passos para instalar o crossCompiler estão no arquivo installCrosscompiler na pasta cMIPS/docs/installCrosscompiler;
    2) Não recomendamos os passos para instalar o ghdl que há no final do arquivo pois esse ghdl não executou em uma das máquinas, caso queira instalá-lo as instruções estão abaixo. 

Instalando o ghdl (caso necessário);

	1) Os passos para instalação estão no link <https://gist.github.com/mathieucaroff/73ccbd30638d9b37b7129a7b7b8d7726>;

Como compilar um arquivo Assembly (.s) ou C (.c):

	As instruções também estão no link: <http://www.inf.ufpr.br/roberto/ci212/labSegm.html>, porém eles dão as instruções bem gerais para executar os exemplos deles.
	1) Rode o comando no terminal:
	alias prompt:=""
	prompt: export PATH=$PATH:~/cmips/cMIPS/bin
	prompt: cd ~/cmips/cMIPS
	prompt: build.sh
