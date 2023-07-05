#!/bin/bash
################################
#
#	Autores: Allan Neri, Daniel Patrício
#	Descrição: Funções uteis para trabalhar com telas 
#	que o usuário irá interagir com o sistema.
#
#
################################

# importar agendapi
file=Agenda.csv
delimitador=","
voltarBtn='--cancel-label=Voltar'

function tela_addUsuario {

	zenity --forms --title="Adicionar Contato:" \
	--text="Preencha os dados do seu contato." \
	--separator="," \
	--add-entry="Nome:" \
	--add-entry="Telefone:" $voltarBtn >> $file
	case $? in
		0)
			echo "Contato Adicionado."
			;;
		1)
			echo "Contato cancelado."
			;;
		-1)
			echo "Erro ao cadastrar contato."
			;;
	esac
	tela_principal

}

function tela_buscarUsuario {
	retorno=`zenity --entry --text="Digite um nome e um numero :"`

	if [[ $? -eq 1 ]] # clicou no botão cancelar
	then
		tela_principal
	fi
	contato=`cat $file | grep "$retorno"`
	nome=$(echo $contato | cut -d',' -f 1)
	numero=$(echo $contato | cut -d',' -f 2)

	zenity --list --column=Nome $nome --column=Telefone  $numero
}

function tela_listarUsuarios {
	
	#aqui os valores da lista serão obtidos de um arquivo
	valoresLista=`cat $file | grep -v '^#' | sort `


	while IFS='' read -r line || [[ -n "$line" ]]; do
    	echo "Text read from file: $line"
	done < "$1"

	nomes=$(echo -e "$valoresLista" | tr ',' ' ' )

	# Deve exibir apenas os valores que não possuem # no arquivo
	#cat Agenda.csv | grep -v '^#'

	selecionado=`zenity --list $voltarBtn --column=Nome --column=Telefone $nomes`
	#tela_principal

	case $1 in
	 \-v )
		tela_principal
	;;
	esac

}

function zerar_Arquivo {
	zenity --question --text="Tem certeza que apagar os Contatos?" $voltarBtn --ok-label="Sim"
	if [[ $? -eq 1 ]] # clicou no botão cancelar
	then
		tela_principal
	fi
	echo "" > Agenda.csv
	tela_principal
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
		echo $1 >> Agenda.csv
		return 1
	else
		return 0
		# indica que existe '|' na entrada
	fi
	
}

function tela_delContato {
	
	tela_listarUsuarios "Selecione Usuário para Excluir"

	if [[ $? -eq 1 ]] # clicou no botão cancelar
	then
		tela_principal
	fi
	contato=`cat $file | grep "$selecionado"`
	sed -i 's/^'$contato'/#$contato/g' '$file'
	tela_principal

}

function tela_principal {
	
	#utilizar estas variaveis para verificar a entrada selecionada
	lstContato="Contatos Cadastrados"
	addContato="Adicionar Contato"
	buscarContato="Buscar contato"
	delContato="Excluir Contato"
	sair="Sair"
	zerarArquivo="Zerar Arquivo"
	
	retorno=`zenity --info --text=Lista --ok-label="$lstContato" --extra-button="$addContato" --extra-button="$buscarContato" --extra-button="$delContato" --extra-button="$zerarArquivo" --extra-button="$sair"`;
	
	if [[ $? == 0 ]] 
	then
		tela_listarUsuarios -v
	fi
	
	case $retorno in
		$addContato )
			tela_addUsuario
		;;
		$buscarContato )
			tela_buscarUsuario
		;;
		$zerarArquivo )
			zerar_Arquivo
		;;
		$delContato )
			tela_delContato
		;;
		$sair )
			exit 0
		;;
	esac

}

tela_principal
