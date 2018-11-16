function tl_receberNovoUsuario {

	saida=`zenity --forms --add-entry=Nome --add-entry=Telefone --title=Cadastrar --text=`;

}

function tl_listarUsuarios {
	
	#aqui os valores da lista serão obtidos de um arquivo
	valoresLista=""
	
	zenity --list --text='Contatos Cadastrados' --column=Nome --column=Telefone $valoresLista

}

function valida_entrada {
	#verifica se foi recebido valores por parametro
	if [ $# -eq 0  ]
	then
		echo "Nenhuma entrada foi dada para ser valiadada"

	#busca apenas as ocorrencias de '|'  e conta quantas existem
	_nome=`echo $1 | grep -o '|' | wc -l `

	if [ $_nome -eq 1 ]
	then
		echo $1 >> contatos
		return 1
	else
		return 0
		# indica que existe '|' na entrada
	fi
	#caso não esteja valido: retornar falso para que a função
	#que o chamou solicite novamente a inserção dos dados
	
}
