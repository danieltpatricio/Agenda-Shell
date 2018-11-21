################################
#
#	Autor: Allan Neri (Daniel refatoração)
#	Descrição: Funções uteis para trabalhar com telas 
#	que o usuário irá interagir com o sistema.
#
#
################################

# importar agendapi

function tela_receberNovoUsuario {

	saida=`zenity --forms --add-entry=Nome --add-entry=Telefone --title=Cadastrar --text=`;

}

function tela_listarUsuarios {
	
	#aqui os valores da lista serão obtidos de um arquivo
	valoresLista=""
	
	zenity --list --text='Contatos Cadastrados' --column=Nome --column=Telefone $valoresLista

}

function valida_entrada {
	#verifica se foi recebido valores por parametro
	if [ $# -eq 0  ]
		then
			echo "Nenhuma entrada foi dada para ser valiadada"
	fi
	#busca apenas as ocorrencias de '|'  e conta quantas existem
	_nome=`echo $1 | grep -o '|' | wc -l `

	#caso não esteja valido: retornar falso para que a função
	#que o chamou solicite novamente a inserção dos dados
		if [[ $_nome -eq 1 ]]; then
			echo $1 >> contatos
			return 1
		else
			return 0
			# indica que existe '|' na entrada
		fi
	fi
}

function tl_delContato {
	
	tl_listarUsuarios

	if [[ $? -eq 1 ]] # clicou no botão cancelar
	then
		tela_principal
	fi

	usr_selecionado=$?



}

function tela_principal {
	
	#utilizar estas variaveis para verificar a entrada selecionada
	lstContato="Contatos Cadastrados"
	addContato="Adicionar Contato"
	delContato="Excluir Contato"
	sair="Sair"
	
	zenity --info --no-wrap --extra-button=$lstContato --ok-label=$addContato --extra-button=$delContato --extra-button=$sair

	# existe diferença no uso de '[' e '[[' (ver link no readme)
	if [[ $?==$lstContato ]] 
	then

		tl_listarUsuarios

	elif [[ $?==$addContato ]] 
	then

		tl_receberNovoUsuario

	elif [[ $?==$delContato ]] 
	then
	
		tl_delContato
		
	elif [[ $?==$sair ]]
	then
	
		exit 0
		
	fi

}
tela_principal