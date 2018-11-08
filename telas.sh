function tl_receberNovoUsuario {

	saida=`zenity --forms --add-entry=Nome --add-entry=Telefone --title=Cadastrar --text=`;

}

function tl_listarUsuarios {
	
	#aqui os valores da lista serão obtidos de um arquivo
	valoresLista=""
	
	zenity --list --text='Contatos Cadastrados' --column=Nome --column=Telefone $valoresLista

}
