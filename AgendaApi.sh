# !bin/bash 
# source biblioteca
function cadastrarContato{
    nome=$1
    numero=$2
    # salvar contato
}

function buscarContato{
    nome=$1
    numero=$2
    # buscar contato
}

function listarContatos{
    #exibir contatos
}

function criarArquivo{
    nome=$1
    # Zerar arquivo de contato o nome serve para nomear o arquivo .txt e chamar a funcao de criar a senha primeiro
}

function criarSenha{
    senha=$1
    # cria a senha e coloca em cada primeira linha do arquivo
}




# Agenda de contatos:

# Escreva uma agenda em shell script que atenda aos seguintes requisitos de negócio:

# Cadastrar nome e telefone;
# Permitir busca;
# Listagem de nome e número;
# Criar novo arquivo de contatos;
# Ter menu de todas opções acima com opção de saída.
# Possuir Persistência em arquivo;
# Solicitar senha para acesso
# Requisitos técnicos:

# Utilize arquivos de textos para cadastro de nomes e telefones
# Utilizem Zenity para desenvolvimento da interface gráfica de TODAS as interações que existam com usuário.
# Solicitar abertura de arquivo ou criação de novo arquivo em caso de nova agenda;
# Deve haver uma biblioteca com funções para cada uma das funções necessárias a execução dos requisitos acima;
# O script principal deve utilizar a biblioteca criada;