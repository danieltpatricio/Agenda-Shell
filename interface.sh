#!/bin/bash
################################
#
<<<<<<< HEAD
#	Autor: Allan Neri (Daniel refatoração)
=======
#	Autores: Allan Neri, Daniel Patrício
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd
#	Descrição: Funções uteis para trabalhar com telas 
#	que o usuário irá interagir com o sistema.
#
#
################################

# importar agendapi
file=Agenda.csv
<<<<<<< HEAD
=======
delimitador=","
voltarBtn='--cancel-label=Voltar'
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd

function tela_addUsuario {

	zenity --forms --title="Adicionar Contato:" \
	--text="Preencha os dados do seu contato." \
	--separator="," \
	--add-entry="Nome:" \
<<<<<<< HEAD
	--add-entry="Telefone:" >> $file
=======
	--add-entry="Telefone:" $voltarBtn >> $file
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd
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

function tela_listarUsuarios {
	
	#aqui os valores da lista serão obtidos de um arquivo
<<<<<<< HEAD
	valoresLista=""
	if [[ -z $1 ]]
	then
		tituloPagina="Contatos Cadastrados"
	else
		tituloPagina=$1
	fi
	zenity --list --text="$tituloPagina" --column=Nome --column=Telefone $valoresLista
=======
	valoresLista=`cat $file | grep -v '^#' | sort `


	file='Agenda.csv'
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
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd

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

<<<<<<< HEAD
	if [[ $? -eq 1 ]] # clicou no botão cancelar
=======
	if [[ $selecionado == '' ]] # clicou no botão cancelar
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd
	then
		tela_principal
	fi

<<<<<<< HEAD
	usr_selecionado=$?
=======
	contato=`cat $file | grep "$selecionado"`

	sed -i 's/^'$contato'/'#$contato'/g' $file
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd

}

function tela_principal {
	
	#utilizar estas variaveis para verificar a entrada selecionada
	lstContato="Contatos Cadastrados"
	addContato="Adicionar Contato"
	delContato="Excluir Contato"
	sair="Sair"
	
<<<<<<< HEAD
	
	retorno=`zenity --info --text=Lista --ok-label="$lstContato" --extra-button="$addContato" --extra-button="$delContato" --extra-button="$sair"`;
	if [[ $? == 0 ]] 
	then
		tela_listarUsuarios
	fi
	case $retorno in
		$addContato )
			tela_receberNovoUsuario
=======
	retorno=`zenity --info --text=Lista --ok-label="$lstContato" --extra-button="$addContato" --extra-button="$delContato" --extra-button="$sair"`;
	
	if [[ $? == 0 ]] 
	then
		tela_listarUsuarios -v
	fi
	
	case $retorno in
		$addContato )
			tela_addUsuario
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd
		;;
		$delContato )
			tela_delContato
		;;
		$sair )
<<<<<<< HEAD
			exit 1
		;;
	esac
}
tela_addUsuario
=======
			exit 0
		;;
	esac

}
#tela_addUsuario
tela_principal
>>>>>>> 15a0c2efe56ce7d664064dacb6c343e4bf32b4bd
