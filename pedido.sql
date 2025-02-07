PGDMP  -    
    
        
    {            pedido    16.0    16.0 �    q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            r           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            s           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            t           1262    24576    pedido    DATABASE     }   CREATE DATABASE pedido WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE pedido;
                postgres    false            �            1255    33076    bairro_log()    FUNCTION     �   CREATE FUNCTION public.bairro_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	insert into bairro_auditoria (idbairro, data_criacao) values (new.idbairro, current_timestamp);
	return new;
end;
$$;
 #   DROP FUNCTION public.bairro_log();
       public          postgres    false            �            1255    33059    formata_moeda(double precision)    FUNCTION     �   CREATE FUNCTION public.formata_moeda(valor double precision) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
begin
	return concat('R$ ', round(cast(valor as numeric), 2));
end;
$_$;
 <   DROP FUNCTION public.formata_moeda(valor double precision);
       public          postgres    false            �            1255    33069 	   get_max()    FUNCTION     �   CREATE FUNCTION public.get_max() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
	return (select idpedido from pedido where valor = (select max(valor) from pedido));
end;
$$;
     DROP FUNCTION public.get_max();
       public          postgres    false            �            1255    33060    get_nome_by_id(integer)    FUNCTION     �   CREATE FUNCTION public.get_nome_by_id(idc integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare r varchar(50);
begin
	select nome into r from cliente where idcliente = idc;
	return r;
end;
$$;
 2   DROP FUNCTION public.get_nome_by_id(idc integer);
       public          postgres    false            �            1255    33065    get_total_by_id(integer)    FUNCTION     �   CREATE FUNCTION public.get_total_by_id(idp integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
	return (select valor from pedido where idpedido = idp);
	
end;
$$;
 3   DROP FUNCTION public.get_total_by_id(idp integer);
       public          postgres    false            �            1255    33070     insere_bairro(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.insere_bairro(IN nome_bairro character varying)
    LANGUAGE sql
    AS $$
	insert into bairro (nome) values(nome_bairro);
$$;
 G   DROP PROCEDURE public.insere_bairro(IN nome_bairro character varying);
       public          postgres    false            �            1255    33081    pedidos_apagados_log()    FUNCTION     i  CREATE FUNCTION public.pedidos_apagados_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	insert into pedidos_apagados(idpedido, idcliente, idtransportadora, idvendedor, data_pedido, valor, data_apagado) 
	values (old.idpedido, old.idcliente, old.idtransportadora, old.idvendedor, old.data_pedido, old.valor, current_timestamp);
	return old;
end;
$$;
 -   DROP FUNCTION public.pedidos_apagados_log();
       public          postgres    false            �            1255    33072 '   update_value(integer, double precision) 	   PROCEDURE     �   CREATE PROCEDURE public.update_value(IN idp integer, IN percentage double precision)
    LANGUAGE sql
    AS $$
	update pedido set valor = round(cast(valor * (1 + (percentage/100)) as numeric), 2) where idpedido = idp;
$$;
 T   DROP PROCEDURE public.update_value(IN idp integer, IN percentage double precision);
       public          postgres    false            �            1259    24605    bairro    TABLE     g   CREATE TABLE public.bairro (
    idbairro integer NOT NULL,
    nome character varying(30) NOT NULL
);
    DROP TABLE public.bairro;
       public         heap    postgres    false            u           0    0    TABLE bairro    ACL     I   GRANT SELECT,INSERT ON TABLE public.bairro TO gerente WITH GRANT OPTION;
          public          postgres    false    219            �            1259    33073    bairro_auditoria    TABLE        CREATE TABLE public.bairro_auditoria (
    idbairro integer NOT NULL,
    data_criacao timestamp without time zone NOT NULL
);
 $   DROP TABLE public.bairro_auditoria;
       public         heap    postgres    false            �            1259    32895    bairro_id_seq    SEQUENCE     u   CREATE SEQUENCE public.bairro_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.bairro_id_seq;
       public          postgres    false    219            v           0    0    bairro_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.bairro_id_seq OWNED BY public.bairro.idbairro;
          public          postgres    false    230            �            1259    24577    cliente    TABLE     �  CREATE TABLE public.cliente (
    idcliente integer NOT NULL,
    nome character varying(50) NOT NULL,
    cpf character(11),
    rg character varying(15),
    data_nascimento date,
    genero character(1),
    logradouro character varying(30),
    numero character varying(10),
    observacoes text,
    idprofissao integer,
    idnacionalidade integer,
    idcomplemento integer,
    idbairro integer,
    idmunicipio integer
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            w           0    0    TABLE cliente    ACL     J   GRANT SELECT,INSERT ON TABLE public.cliente TO gerente WITH GRANT OPTION;
          public          postgres    false    215            �            1259    32897    cliente_id_seq    SEQUENCE     x   CREATE SEQUENCE public.cliente_id_seq
    START WITH 18
    INCREMENT BY 1
    MINVALUE 18
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cliente_id_seq;
       public          postgres    false    215            x           0    0    cliente_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.idcliente;
          public          postgres    false    231            �            1259    24598    complemento    TABLE     q   CREATE TABLE public.complemento (
    idcomplemento integer NOT NULL,
    nome character varying(30) NOT NULL
);
    DROP TABLE public.complemento;
       public         heap    postgres    false            y           0    0    TABLE complemento    ACL     N   GRANT SELECT,INSERT ON TABLE public.complemento TO gerente WITH GRANT OPTION;
          public          postgres    false    218            �            1259    32899    complemento_id_seq    SEQUENCE     z   CREATE SEQUENCE public.complemento_id_seq
    START WITH 3
    INCREMENT BY 1
    MINVALUE 3
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.complemento_id_seq;
       public          postgres    false    218            z           0    0    complemento_id_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public.complemento_id_seq OWNED BY public.complemento.idcomplemento;
          public          postgres    false    232            �            1259    33096    conta    TABLE     �   CREATE TABLE public.conta (
    idconta integer NOT NULL,
    cliente character varying(50) NOT NULL,
    saldo integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.conta;
       public         heap    postgres    false            �            1259    33095    conta_idconta_seq    SEQUENCE     �   CREATE SEQUENCE public.conta_idconta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.conta_idconta_seq;
       public          postgres    false    244            {           0    0    conta_idconta_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.conta_idconta_seq OWNED BY public.conta.idconta;
          public          postgres    false    243            �            1259    32814 
   fornecedor    TABLE     o   CREATE TABLE public.fornecedor (
    idfornecedor integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.fornecedor;
       public         heap    postgres    false            |           0    0    TABLE fornecedor    ACL     M   GRANT SELECT,INSERT ON TABLE public.fornecedor TO gerente WITH GRANT OPTION;
          public          postgres    false    222            �            1259    32901    fornecedor_id_seq    SEQUENCE     y   CREATE SEQUENCE public.fornecedor_id_seq
    START WITH 4
    INCREMENT BY 1
    MINVALUE 4
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fornecedor_id_seq;
       public          postgres    false    222            }           0    0    fornecedor_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.idfornecedor;
          public          postgres    false    233            �            1259    32797 	   municipio    TABLE     �   CREATE TABLE public.municipio (
    idmunicipio integer NOT NULL,
    nome character varying(30) NOT NULL,
    iduf integer NOT NULL
);
    DROP TABLE public.municipio;
       public         heap    postgres    false            ~           0    0    TABLE municipio    ACL     L   GRANT SELECT,INSERT ON TABLE public.municipio TO gerente WITH GRANT OPTION;
          public          postgres    false    221            �            1259    32903    municipio_id_seq    SEQUENCE     z   CREATE SEQUENCE public.municipio_id_seq
    START WITH 10
    INCREMENT BY 1
    MINVALUE 10
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.municipio_id_seq;
       public          postgres    false    221                       0    0    municipio_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.municipio_id_seq OWNED BY public.municipio.idmunicipio;
          public          postgres    false    234            �            1259    32788    uf    TABLE     �   CREATE TABLE public.uf (
    iduf integer NOT NULL,
    nome character varying(30) NOT NULL,
    sigla character(2) NOT NULL
);
    DROP TABLE public.uf;
       public         heap    postgres    false            �           0    0    TABLE uf    ACL     E   GRANT SELECT,INSERT ON TABLE public.uf TO gerente WITH GRANT OPTION;
          public          postgres    false    220            �            1259    32887    municipio_uf    VIEW     �   CREATE VIEW public.municipio_uf AS
 SELECT mnc.nome,
    ufd.nome AS "nome da UF",
    ufd.sigla
   FROM (public.municipio mnc
     LEFT JOIN public.uf ufd ON ((ufd.iduf = mnc.iduf)));
    DROP VIEW public.municipio_uf;
       public          postgres    false    221    220    220    220    221            �            1259    24591    nacionalidade    TABLE     u   CREATE TABLE public.nacionalidade (
    idnacionalidade integer NOT NULL,
    nome character varying(30) NOT NULL
);
 !   DROP TABLE public.nacionalidade;
       public         heap    postgres    false            �           0    0    TABLE nacionalidade    ACL     P   GRANT SELECT,INSERT ON TABLE public.nacionalidade TO gerente WITH GRANT OPTION;
          public          postgres    false    217            �            1259    32905    nacionalidade_id_seq    SEQUENCE     |   CREATE SEQUENCE public.nacionalidade_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.nacionalidade_id_seq;
       public          postgres    false    217            �           0    0    nacionalidade_id_seq    SEQUENCE OWNED BY     Z   ALTER SEQUENCE public.nacionalidade_id_seq OWNED BY public.nacionalidade.idnacionalidade;
          public          postgres    false    235            �            1259    32852    pedido    TABLE     �   CREATE TABLE public.pedido (
    idpedido integer NOT NULL,
    idcliente integer NOT NULL,
    idtransportadora integer,
    idvendedor integer NOT NULL,
    data_pedido date NOT NULL,
    valor double precision NOT NULL
);
    DROP TABLE public.pedido;
       public         heap    postgres    false            �           0    0    TABLE pedido    ACL     I   GRANT SELECT,INSERT ON TABLE public.pedido TO gerente WITH GRANT OPTION;
          public          postgres    false    226            �            1259    32907    pedido_id_seq    SEQUENCE     w   CREATE SEQUENCE public.pedido_id_seq
    START WITH 16
    INCREMENT BY 1
    MINVALUE 16
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.pedido_id_seq;
       public          postgres    false    226            �           0    0    pedido_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.pedido_id_seq OWNED BY public.pedido.idpedido;
          public          postgres    false    236            �            1259    32872    pedido_produto    TABLE     �   CREATE TABLE public.pedido_produto (
    idpedido integer NOT NULL,
    idproduto integer NOT NULL,
    quantidade integer DEFAULT 1 NOT NULL,
    valor_unitario double precision DEFAULT 0 NOT NULL
);
 "   DROP TABLE public.pedido_produto;
       public         heap    postgres    false            �           0    0    TABLE pedido_produto    ACL     Q   GRANT SELECT,INSERT ON TABLE public.pedido_produto TO gerente WITH GRANT OPTION;
          public          postgres    false    227            �            1259    33086    pedidos_apagados    TABLE       CREATE TABLE public.pedidos_apagados (
    idpedido integer NOT NULL,
    idcliente integer NOT NULL,
    idtransportadora integer,
    idvendedor integer NOT NULL,
    data_pedido date NOT NULL,
    valor numeric(10,2) NOT NULL,
    data_apagado date NOT NULL
);
 $   DROP TABLE public.pedidos_apagados;
       public         heap    postgres    false            �            1259    32840    produto    TABLE     �   CREATE TABLE public.produto (
    idproduto integer NOT NULL,
    idfornecedor integer NOT NULL,
    nome character varying(50) NOT NULL,
    valor numeric(10,2) DEFAULT 0 NOT NULL
);
    DROP TABLE public.produto;
       public         heap    postgres    false            �           0    0    TABLE produto    ACL     J   GRANT SELECT,INSERT ON TABLE public.produto TO gerente WITH GRANT OPTION;
          public          postgres    false    225            �            1259    32891    produto_fornecedor    VIEW     �   CREATE VIEW public.produto_fornecedor AS
 SELECT pdt.nome,
    pdt.valor,
    fnc.nome AS forcenedor
   FROM (public.produto pdt
     LEFT JOIN public.fornecedor fnc ON ((fnc.idfornecedor = pdt.idfornecedor)));
 %   DROP VIEW public.produto_fornecedor;
       public          postgres    false    225    225    225    222    222            �            1259    24584 	   profissao    TABLE     m   CREATE TABLE public.profissao (
    idprofissao integer NOT NULL,
    nome character varying(30) NOT NULL
);
    DROP TABLE public.profissao;
       public         heap    postgres    false            �           0    0    TABLE profissao    ACL     L   GRANT SELECT,INSERT ON TABLE public.profissao TO gerente WITH GRANT OPTION;
          public          postgres    false    216            �            1259    32909    profissao_id_seq    SEQUENCE     x   CREATE SEQUENCE public.profissao_id_seq
    START WITH 6
    INCREMENT BY 1
    MINVALUE 6
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.profissao_id_seq;
       public          postgres    false    216            �           0    0    profissao_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.profissao_id_seq OWNED BY public.profissao.idprofissao;
          public          postgres    false    237            �            1259    32828    transportadora    TABLE     �   CREATE TABLE public.transportadora (
    idtransportadora integer NOT NULL,
    idmunicipio integer,
    logradouro character varying(50),
    numero character varying(10),
    nome character varying(50) NOT NULL
);
 "   DROP TABLE public.transportadora;
       public         heap    postgres    false            �           0    0    TABLE transportadora    ACL     Q   GRANT SELECT,INSERT ON TABLE public.transportadora TO gerente WITH GRANT OPTION;
          public          postgres    false    224            �            1259    32911    transportadora_id_seq    SEQUENCE     }   CREATE SEQUENCE public.transportadora_id_seq
    START WITH 3
    INCREMENT BY 1
    MINVALUE 3
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.transportadora_id_seq;
       public          postgres    false    224            �           0    0    transportadora_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.transportadora_id_seq OWNED BY public.transportadora.idtransportadora;
          public          postgres    false    238            �            1259    32913 	   uf_id_seq    SEQUENCE     q   CREATE SEQUENCE public.uf_id_seq
    START WITH 7
    INCREMENT BY 1
    MINVALUE 7
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.uf_id_seq;
       public          postgres    false    220            �           0    0 	   uf_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.uf_id_seq OWNED BY public.uf.iduf;
          public          postgres    false    239            �            1259    32821    vendedor    TABLE     k   CREATE TABLE public.vendedor (
    idvendedor integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.vendedor;
       public         heap    postgres    false            �           0    0    TABLE vendedor    ACL     K   GRANT SELECT,INSERT ON TABLE public.vendedor TO gerente WITH GRANT OPTION;
          public          postgres    false    223            �            1259    32915    vendedor_id_seq    SEQUENCE     w   CREATE SEQUENCE public.vendedor_id_seq
    START WITH 9
    INCREMENT BY 1
    MINVALUE 9
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.vendedor_id_seq;
       public          postgres    false    223            �           0    0    vendedor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.vendedor_id_seq OWNED BY public.vendedor.idvendedor;
          public          postgres    false    240            u           2604    32896    bairro idbairro    DEFAULT     l   ALTER TABLE ONLY public.bairro ALTER COLUMN idbairro SET DEFAULT nextval('public.bairro_id_seq'::regclass);
 >   ALTER TABLE public.bairro ALTER COLUMN idbairro DROP DEFAULT;
       public          postgres    false    230    219            q           2604    32898    cliente idcliente    DEFAULT     o   ALTER TABLE ONLY public.cliente ALTER COLUMN idcliente SET DEFAULT nextval('public.cliente_id_seq'::regclass);
 @   ALTER TABLE public.cliente ALTER COLUMN idcliente DROP DEFAULT;
       public          postgres    false    231    215            t           2604    32900    complemento idcomplemento    DEFAULT     {   ALTER TABLE ONLY public.complemento ALTER COLUMN idcomplemento SET DEFAULT nextval('public.complemento_id_seq'::regclass);
 H   ALTER TABLE public.complemento ALTER COLUMN idcomplemento DROP DEFAULT;
       public          postgres    false    232    218                       2604    33099    conta idconta    DEFAULT     n   ALTER TABLE ONLY public.conta ALTER COLUMN idconta SET DEFAULT nextval('public.conta_idconta_seq'::regclass);
 <   ALTER TABLE public.conta ALTER COLUMN idconta DROP DEFAULT;
       public          postgres    false    243    244    244            x           2604    32902    fornecedor idfornecedor    DEFAULT     x   ALTER TABLE ONLY public.fornecedor ALTER COLUMN idfornecedor SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);
 F   ALTER TABLE public.fornecedor ALTER COLUMN idfornecedor DROP DEFAULT;
       public          postgres    false    233    222            w           2604    32904    municipio idmunicipio    DEFAULT     u   ALTER TABLE ONLY public.municipio ALTER COLUMN idmunicipio SET DEFAULT nextval('public.municipio_id_seq'::regclass);
 D   ALTER TABLE public.municipio ALTER COLUMN idmunicipio DROP DEFAULT;
       public          postgres    false    234    221            s           2604    32906    nacionalidade idnacionalidade    DEFAULT     �   ALTER TABLE ONLY public.nacionalidade ALTER COLUMN idnacionalidade SET DEFAULT nextval('public.nacionalidade_id_seq'::regclass);
 L   ALTER TABLE public.nacionalidade ALTER COLUMN idnacionalidade DROP DEFAULT;
       public          postgres    false    235    217            |           2604    32908    pedido idpedido    DEFAULT     l   ALTER TABLE ONLY public.pedido ALTER COLUMN idpedido SET DEFAULT nextval('public.pedido_id_seq'::regclass);
 >   ALTER TABLE public.pedido ALTER COLUMN idpedido DROP DEFAULT;
       public          postgres    false    236    226            r           2604    32910    profissao idprofissao    DEFAULT     u   ALTER TABLE ONLY public.profissao ALTER COLUMN idprofissao SET DEFAULT nextval('public.profissao_id_seq'::regclass);
 D   ALTER TABLE public.profissao ALTER COLUMN idprofissao DROP DEFAULT;
       public          postgres    false    237    216            z           2604    32912    transportadora idtransportadora    DEFAULT     �   ALTER TABLE ONLY public.transportadora ALTER COLUMN idtransportadora SET DEFAULT nextval('public.transportadora_id_seq'::regclass);
 N   ALTER TABLE public.transportadora ALTER COLUMN idtransportadora DROP DEFAULT;
       public          postgres    false    238    224            v           2604    32914    uf iduf    DEFAULT     `   ALTER TABLE ONLY public.uf ALTER COLUMN iduf SET DEFAULT nextval('public.uf_id_seq'::regclass);
 6   ALTER TABLE public.uf ALTER COLUMN iduf DROP DEFAULT;
       public          postgres    false    239    220            y           2604    32916    vendedor idvendedor    DEFAULT     r   ALTER TABLE ONLY public.vendedor ALTER COLUMN idvendedor SET DEFAULT nextval('public.vendedor_id_seq'::regclass);
 B   ALTER TABLE public.vendedor ALTER COLUMN idvendedor DROP DEFAULT;
       public          postgres    false    240    223            W          0    24605    bairro 
   TABLE DATA           0   COPY public.bairro (idbairro, nome) FROM stdin;
    public          postgres    false    219   E�       k          0    33073    bairro_auditoria 
   TABLE DATA           B   COPY public.bairro_auditoria (idbairro, data_criacao) FROM stdin;
    public          postgres    false    241   ��       S          0    24577    cliente 
   TABLE DATA           �   COPY public.cliente (idcliente, nome, cpf, rg, data_nascimento, genero, logradouro, numero, observacoes, idprofissao, idnacionalidade, idcomplemento, idbairro, idmunicipio) FROM stdin;
    public          postgres    false    215   �       V          0    24598    complemento 
   TABLE DATA           :   COPY public.complemento (idcomplemento, nome) FROM stdin;
    public          postgres    false    218   ��       n          0    33096    conta 
   TABLE DATA           8   COPY public.conta (idconta, cliente, saldo) FROM stdin;
    public          postgres    false    244   *�       Z          0    32814 
   fornecedor 
   TABLE DATA           8   COPY public.fornecedor (idfornecedor, nome) FROM stdin;
    public          postgres    false    222   _�       Y          0    32797 	   municipio 
   TABLE DATA           <   COPY public.municipio (idmunicipio, nome, iduf) FROM stdin;
    public          postgres    false    221   ��       U          0    24591    nacionalidade 
   TABLE DATA           >   COPY public.nacionalidade (idnacionalidade, nome) FROM stdin;
    public          postgres    false    217   ?�       ^          0    32852    pedido 
   TABLE DATA           g   COPY public.pedido (idpedido, idcliente, idtransportadora, idvendedor, data_pedido, valor) FROM stdin;
    public          postgres    false    226   ��       _          0    32872    pedido_produto 
   TABLE DATA           Y   COPY public.pedido_produto (idpedido, idproduto, quantidade, valor_unitario) FROM stdin;
    public          postgres    false    227   3�       l          0    33086    pedidos_apagados 
   TABLE DATA              COPY public.pedidos_apagados (idpedido, idcliente, idtransportadora, idvendedor, data_pedido, valor, data_apagado) FROM stdin;
    public          postgres    false    242   ��       ]          0    32840    produto 
   TABLE DATA           G   COPY public.produto (idproduto, idfornecedor, nome, valor) FROM stdin;
    public          postgres    false    225   �       T          0    24584 	   profissao 
   TABLE DATA           6   COPY public.profissao (idprofissao, nome) FROM stdin;
    public          postgres    false    216   q�       \          0    32828    transportadora 
   TABLE DATA           a   COPY public.transportadora (idtransportadora, idmunicipio, logradouro, numero, nome) FROM stdin;
    public          postgres    false    224   ǯ       X          0    32788    uf 
   TABLE DATA           /   COPY public.uf (iduf, nome, sigla) FROM stdin;
    public          postgres    false    220   �       [          0    32821    vendedor 
   TABLE DATA           4   COPY public.vendedor (idvendedor, nome) FROM stdin;
    public          postgres    false    223   ��       �           0    0    bairro_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.bairro_id_seq', 8, true);
          public          postgres    false    230            �           0    0    cliente_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cliente_id_seq', 18, false);
          public          postgres    false    231            �           0    0    complemento_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.complemento_id_seq', 3, false);
          public          postgres    false    232            �           0    0    conta_idconta_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.conta_idconta_seq', 2, true);
          public          postgres    false    243            �           0    0    fornecedor_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.fornecedor_id_seq', 4, false);
          public          postgres    false    233            �           0    0    municipio_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.municipio_id_seq', 10, false);
          public          postgres    false    234            �           0    0    nacionalidade_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.nacionalidade_id_seq', 5, false);
          public          postgres    false    235            �           0    0    pedido_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.pedido_id_seq', 16, true);
          public          postgres    false    236            �           0    0    profissao_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.profissao_id_seq', 6, false);
          public          postgres    false    237            �           0    0    transportadora_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.transportadora_id_seq', 3, false);
          public          postgres    false    238            �           0    0 	   uf_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.uf_id_seq', 7, false);
          public          postgres    false    239            �           0    0    vendedor_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.vendedor_id_seq', 9, false);
          public          postgres    false    240            �           2606    33102    conta conta_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.conta
    ADD CONSTRAINT conta_pkey PRIMARY KEY (idconta);
 :   ALTER TABLE ONLY public.conta DROP CONSTRAINT conta_pkey;
       public            postgres    false    244            �           2606    24609    bairro pk_brr_idbairro 
   CONSTRAINT     Z   ALTER TABLE ONLY public.bairro
    ADD CONSTRAINT pk_brr_idbairro PRIMARY KEY (idbairro);
 @   ALTER TABLE ONLY public.bairro DROP CONSTRAINT pk_brr_idbairro;
       public            postgres    false    219            �           2606    24583    cliente pk_cln_idcliente 
   CONSTRAINT     ]   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cln_idcliente PRIMARY KEY (idcliente);
 B   ALTER TABLE ONLY public.cliente DROP CONSTRAINT pk_cln_idcliente;
       public            postgres    false    215            �           2606    24602     complemento pk_cpl_idcomplemento 
   CONSTRAINT     i   ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT pk_cpl_idcomplemento PRIMARY KEY (idcomplemento);
 J   ALTER TABLE ONLY public.complemento DROP CONSTRAINT pk_cpl_idcomplemento;
       public            postgres    false    218            �           2606    32818    fornecedor pk_fncd_idfornecedor 
   CONSTRAINT     g   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT pk_fncd_idfornecedor PRIMARY KEY (idfornecedor);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT pk_fncd_idfornecedor;
       public            postgres    false    222            �           2606    32801    municipio pk_mnc_idmunicipio 
   CONSTRAINT     c   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT pk_mnc_idmunicipio PRIMARY KEY (idmunicipio);
 F   ALTER TABLE ONLY public.municipio DROP CONSTRAINT pk_mnc_idmunicipio;
       public            postgres    false    221            �           2606    24595 $   nacionalidade pk_ncn_idnacionalidade 
   CONSTRAINT     o   ALTER TABLE ONLY public.nacionalidade
    ADD CONSTRAINT pk_ncn_idnacionalidade PRIMARY KEY (idnacionalidade);
 N   ALTER TABLE ONLY public.nacionalidade DROP CONSTRAINT pk_ncn_idnacionalidade;
       public            postgres    false    217            �           2606    32856    pedido pk_pdd_idpedido 
   CONSTRAINT     Z   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pk_pdd_idpedido PRIMARY KEY (idpedido);
 @   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pk_pdd_idpedido;
       public            postgres    false    226            �           2606    32876 %   pedido_produto pk_pdp_idpedidoproduto 
   CONSTRAINT     t   ALTER TABLE ONLY public.pedido_produto
    ADD CONSTRAINT pk_pdp_idpedidoproduto PRIMARY KEY (idpedido, idproduto);
 O   ALTER TABLE ONLY public.pedido_produto DROP CONSTRAINT pk_pdp_idpedidoproduto;
       public            postgres    false    227    227            �           2606    32844    produto pk_pdt_idproduto 
   CONSTRAINT     ]   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT pk_pdt_idproduto PRIMARY KEY (idproduto);
 B   ALTER TABLE ONLY public.produto DROP CONSTRAINT pk_pdt_idproduto;
       public            postgres    false    225            �           2606    24588    profissao pk_prf_idprofissao 
   CONSTRAINT     c   ALTER TABLE ONLY public.profissao
    ADD CONSTRAINT pk_prf_idprofissao PRIMARY KEY (idprofissao);
 F   ALTER TABLE ONLY public.profissao DROP CONSTRAINT pk_prf_idprofissao;
       public            postgres    false    216            �           2606    32832 &   transportadora pk_tpt_idtransportadora 
   CONSTRAINT     r   ALTER TABLE ONLY public.transportadora
    ADD CONSTRAINT pk_tpt_idtransportadora PRIMARY KEY (idtransportadora);
 P   ALTER TABLE ONLY public.transportadora DROP CONSTRAINT pk_tpt_idtransportadora;
       public            postgres    false    224            �           2606    32792     uf pk_ufd_idunindade_ferederacao 
   CONSTRAINT     `   ALTER TABLE ONLY public.uf
    ADD CONSTRAINT pk_ufd_idunindade_ferederacao PRIMARY KEY (iduf);
 J   ALTER TABLE ONLY public.uf DROP CONSTRAINT pk_ufd_idunindade_ferederacao;
       public            postgres    false    220            �           2606    32825    vendedor pk_vdd_idvendedor 
   CONSTRAINT     `   ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT pk_vdd_idvendedor PRIMARY KEY (idvendedor);
 D   ALTER TABLE ONLY public.vendedor DROP CONSTRAINT pk_vdd_idvendedor;
       public            postgres    false    223            �           2606    24611    bairro un_brr_nome 
   CONSTRAINT     M   ALTER TABLE ONLY public.bairro
    ADD CONSTRAINT un_brr_nome UNIQUE (nome);
 <   ALTER TABLE ONLY public.bairro DROP CONSTRAINT un_brr_nome;
       public            postgres    false    219            �           2606    24604    complemento un_cpl_nome 
   CONSTRAINT     R   ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT un_cpl_nome UNIQUE (nome);
 A   ALTER TABLE ONLY public.complemento DROP CONSTRAINT un_cpl_nome;
       public            postgres    false    218            �           2606    32820    fornecedor un_fncd_nome 
   CONSTRAINT     R   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT un_fncd_nome UNIQUE (nome);
 A   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT un_fncd_nome;
       public            postgres    false    222            �           2606    32803    municipio un_mnc_nome 
   CONSTRAINT     P   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT un_mnc_nome UNIQUE (nome);
 ?   ALTER TABLE ONLY public.municipio DROP CONSTRAINT un_mnc_nome;
       public            postgres    false    221            �           2606    24597    nacionalidade un_ncn_nome 
   CONSTRAINT     T   ALTER TABLE ONLY public.nacionalidade
    ADD CONSTRAINT un_ncn_nome UNIQUE (nome);
 C   ALTER TABLE ONLY public.nacionalidade DROP CONSTRAINT un_ncn_nome;
       public            postgres    false    217            �           2606    32846    produto un_pdt_nome 
   CONSTRAINT     N   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT un_pdt_nome UNIQUE (nome);
 =   ALTER TABLE ONLY public.produto DROP CONSTRAINT un_pdt_nome;
       public            postgres    false    225            �           2606    24590    profissao un_prf_nome 
   CONSTRAINT     P   ALTER TABLE ONLY public.profissao
    ADD CONSTRAINT un_prf_nome UNIQUE (nome);
 ?   ALTER TABLE ONLY public.profissao DROP CONSTRAINT un_prf_nome;
       public            postgres    false    216            �           2606    32834    transportadora un_tpt_nome 
   CONSTRAINT     U   ALTER TABLE ONLY public.transportadora
    ADD CONSTRAINT un_tpt_nome UNIQUE (nome);
 D   ALTER TABLE ONLY public.transportadora DROP CONSTRAINT un_tpt_nome;
       public            postgres    false    224            �           2606    32794    uf un_ufd_nome 
   CONSTRAINT     I   ALTER TABLE ONLY public.uf
    ADD CONSTRAINT un_ufd_nome UNIQUE (nome);
 8   ALTER TABLE ONLY public.uf DROP CONSTRAINT un_ufd_nome;
       public            postgres    false    220            �           2606    32796    uf un_ufd_sigla 
   CONSTRAINT     K   ALTER TABLE ONLY public.uf
    ADD CONSTRAINT un_ufd_sigla UNIQUE (sigla);
 9   ALTER TABLE ONLY public.uf DROP CONSTRAINT un_ufd_sigla;
       public            postgres    false    220            �           2606    32827    vendedor un_vdd_nome 
   CONSTRAINT     O   ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT un_vdd_nome UNIQUE (nome);
 >   ALTER TABLE ONLY public.vendedor DROP CONSTRAINT un_vdd_nome;
       public            postgres    false    223            �           2620    33077    bairro log_bairro_trigger    TRIGGER     s   CREATE TRIGGER log_bairro_trigger AFTER INSERT ON public.bairro FOR EACH ROW EXECUTE FUNCTION public.bairro_log();
 2   DROP TRIGGER log_bairro_trigger ON public.bairro;
       public          postgres    false    251    219            �           2620    33082 !   pedido log_pedido_apagado_trigger    TRIGGER     �   CREATE TRIGGER log_pedido_apagado_trigger AFTER DELETE ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.pedidos_apagados_log();
 :   DROP TRIGGER log_pedido_apagado_trigger ON public.pedido;
       public          postgres    false    226    252            �           2606    32809    cliente fk_cliente_idmunicipio    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cliente_idmunicipio FOREIGN KEY (idmunicipio) REFERENCES public.municipio(idmunicipio);
 H   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cliente_idmunicipio;
       public          postgres    false    221    215    4762            �           2606    32783    cliente fk_cln_idbairro    FK CONSTRAINT     ~   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idbairro FOREIGN KEY (idbairro) REFERENCES public.bairro(idbairro);
 A   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idbairro;
       public          postgres    false    219    215    4752            �           2606    32778    cliente fk_cln_idcomplemento    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idcomplemento FOREIGN KEY (idcomplemento) REFERENCES public.complemento(idcomplemento);
 F   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idcomplemento;
       public          postgres    false    218    215    4748            �           2606    32773    cliente fk_cln_idnacionalidade    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idnacionalidade FOREIGN KEY (idnacionalidade) REFERENCES public.nacionalidade(idnacionalidade);
 H   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idnacionalidade;
       public          postgres    false    215    4744    217            �           2606    32768    cliente fk_cln_idprofissao    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idprofissao FOREIGN KEY (idprofissao) REFERENCES public.profissao(idprofissao);
 D   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idprofissao;
       public          postgres    false    216    215    4740            �           2606    32804    municipio fk_mnc_iduf    FK CONSTRAINT     p   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT fk_mnc_iduf FOREIGN KEY (iduf) REFERENCES public.uf(iduf);
 ?   ALTER TABLE ONLY public.municipio DROP CONSTRAINT fk_mnc_iduf;
       public          postgres    false    221    4756    220            �           2606    32857    pedido fk_pdd_idcliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pdd_idcliente FOREIGN KEY (idcliente) REFERENCES public.cliente(idcliente);
 A   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pdd_idcliente;
       public          postgres    false    226    4738    215            �           2606    32862    pedido fk_pdd_idtransportadora    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pdd_idtransportadora FOREIGN KEY (idtransportadora) REFERENCES public.transportadora(idtransportadora);
 H   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pdd_idtransportadora;
       public          postgres    false    4774    224    226            �           2606    32867    pedido fk_pdd_idvendedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pdd_idvendedor FOREIGN KEY (idvendedor) REFERENCES public.vendedor(idvendedor);
 B   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pdd_idvendedor;
       public          postgres    false    223    226    4770            �           2606    32877    pedido_produto fk_pdp_idpedido    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_produto
    ADD CONSTRAINT fk_pdp_idpedido FOREIGN KEY (idpedido) REFERENCES public.pedido(idpedido);
 H   ALTER TABLE ONLY public.pedido_produto DROP CONSTRAINT fk_pdp_idpedido;
       public          postgres    false    227    226    4782            �           2606    32882    pedido_produto fk_pdp_idproduto    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_produto
    ADD CONSTRAINT fk_pdp_idproduto FOREIGN KEY (idproduto) REFERENCES public.produto(idproduto);
 I   ALTER TABLE ONLY public.pedido_produto DROP CONSTRAINT fk_pdp_idproduto;
       public          postgres    false    227    225    4778            �           2606    32847    produto fk_pdt_idfornecedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_pdt_idfornecedor FOREIGN KEY (idfornecedor) REFERENCES public.fornecedor(idfornecedor);
 E   ALTER TABLE ONLY public.produto DROP CONSTRAINT fk_pdt_idfornecedor;
       public          postgres    false    4766    225    222            �           2606    32835 !   transportadora fk_tpt_idmunicipio    FK CONSTRAINT     �   ALTER TABLE ONLY public.transportadora
    ADD CONSTRAINT fk_tpt_idmunicipio FOREIGN KEY (idmunicipio) REFERENCES public.municipio(idmunicipio);
 K   ALTER TABLE ONLY public.transportadora DROP CONSTRAINT fk_tpt_idmunicipio;
       public          postgres    false    4762    224    221            W   ]   x�3�t�LILIU��/K�2�tN�+)��2�>�8_! 5�1�N�+IT�/N�2�I-.IU((�ONM)-J�2��r�CYF\P�1W� `y      k   /   x�3�4202�54�52R04�2��25Գ4100�2�#g�G.F��� ��0      S   �  x�mSKn�0]O�8 ��(.].�Yt�c�ID%��}z�n}�ΐ�,�PH���)�v�p��2��㖖�_��po���)&h���Z��k��0���ڮ�Pqj@)Ն�������~]c_����)�;X.�|m/�1����Իf#���v���m�Z@^	�^�(��G��"��1if�}��o�e $4�P�>���Q����ʍč�k:3J���k1Ph؅�K4�egXK��T�I-p�p���
���X"*D>��9��FzF;|�h2��Vk��¶ϓA���|%�ޓM��:����⹒3NF(�ؾ�ߒ�sU���ڗ�YGf��vfaE�?�{ۥ�f��}xd���g_ؐ�H�̞�b2���pn�)�q���ĸ0��D�h(�>vE>k��*�ɜ���.��]�ꄇ����֟�S�Jc����a#���v����r5�^(C{��Q��+�|�'{��$��n�P      V   "   x�3�tN,N�2�t,H,*I�M�+������ c�&      n   %   x�3�t��L�+IU0�4400�2�q��1z\\\ ��      Z   7   x�3�tN,�Sp��-(-IL�/J-�2�ttD2�tr�S�=���43/��+F��� C�      Y   �   x�MN;
�@�gN1'�UKI�
J�lF2��2c���#��\H
���Ѩ!}
,�c��~fT��%��끡�zQq�Ա��L6p�q�*l��&�#/��0��cz�kjܭ͇(whp����A�rn4�      U   >   x�3�t*J,��I�,J�2��,I��L�K�2���/*I�u�M-�L��p:��^����� �R{      ^   �   x�e��D!C�����&���� Ύ�b���UD���������^���p;x�R���ްA��u�s'����f�I�� -S�K����$ �D��H�&�u5�-�ъl�0[�4���e��m���#�J����T�	�f�צ:      _   ^   x�M�I�0�5������?�P5]�%|�]"�T��e����9YJS����3m��f��P|��Տ�^��3�΀g���^�� �D      l   /   x�34�4��FFF��@�idl�g` 1�54�52����� �L      ]   �   x�3�4���L.�O��-(-IL�/�00�30�2I��e� �L!BƜF�9�ɉ
���rADM��.���`�)\MJ�B��)��0�f�Ɯ����7e&*9�rB�́6�'&e楖�r���b���� ̌(      T   F   x�3�t-.)MI�+I�2�t�KO��H�,��2�HM)3M8���s2�K�L9���R���b���� Ͱ�      \   A   x�3��*MTHI,V���M,�40�t
�S)J�+.�/*I-�2�4���м�Ë�Q$c���� ��o      X   r   x���	�0E���*�C>N^��f��Z�d���R�XD��{o0փ:�`+��I�l��1�v}]#��aQ�Xz�kȍe�dD*��k��������N3k.͑fy"�o"_      [   P   x�3�t�K):��ˈ�1'��8?�˘�+�(b�阙S0��M,�L�2�.M�I��2��K����)K�K����� ���     