function tl_receberNovoUsuario {

	saida=`zenity --forms --add-entry=Nome --add-entry=Telefone --title=Cadastrar --text=`;

}

function tl_listarUsuarios {

	valoresLista=""
	
	zenity --list --text=Contatos Cadastrados --column=Nome --column=Telefone $valoresLista


}
