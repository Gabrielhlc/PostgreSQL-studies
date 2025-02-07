PGDMP  (        
        
    {         
   biblioteca    16.0    16.0 A               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    32920 
   biblioteca    DATABASE     �   CREATE DATABASE biblioteca WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE biblioteca;
                postgres    false            �            1259    33017    aluno    TABLE     e   CREATE TABLE public.aluno (
    idaluno integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.aluno;
       public         heap    postgres    false            �            1259    33016    aluno_idaluno_seq    SEQUENCE     �   CREATE SEQUENCE public.aluno_idaluno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.aluno_idaluno_seq;
       public          postgres    false    225                       0    0    aluno_idaluno_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.aluno_idaluno_seq OWNED BY public.aluno.idaluno;
          public          postgres    false    224            �            1259    32940    autor    TABLE     e   CREATE TABLE public.autor (
    idautor integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.autor;
       public         heap    postgres    false            �            1259    32939    autor_idautor_seq    SEQUENCE     �   CREATE SEQUENCE public.autor_idautor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.autor_idautor_seq;
       public          postgres    false    220                       0    0    autor_idautor_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.autor_idautor_seq OWNED BY public.autor.idautor;
          public          postgres    false    219            �            1259    32931 	   categoria    TABLE     m   CREATE TABLE public.categoria (
    idcategoria integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.categoria;
       public         heap    postgres    false            �            1259    32930    categoria_idcategoria_seq    SEQUENCE     �   CREATE SEQUENCE public.categoria_idcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.categoria_idcategoria_seq;
       public          postgres    false    218                       0    0    categoria_idcategoria_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.categoria_idcategoria_seq OWNED BY public.categoria.idcategoria;
          public          postgres    false    217            �            1259    32922    editora    TABLE     i   CREATE TABLE public.editora (
    ideditora integer NOT NULL,
    nome character varying(30) NOT NULL
);
    DROP TABLE public.editora;
       public         heap    postgres    false            �            1259    32921    editora_ideditora_seq    SEQUENCE     �   CREATE SEQUENCE public.editora_ideditora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.editora_ideditora_seq;
       public          postgres    false    216                       0    0    editora_ideditora_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.editora_ideditora_seq OWNED BY public.editora.ideditora;
          public          postgres    false    215            �            1259    33024 
   emprestimo    TABLE       CREATE TABLE public.emprestimo (
    idemprestimo integer NOT NULL,
    idaluno integer NOT NULL,
    data_emprestimo date DEFAULT CURRENT_DATE NOT NULL,
    data_devolucao date NOT NULL,
    valor numeric(10,2) NOT NULL,
    devolvido character(1) NOT NULL
);
    DROP TABLE public.emprestimo;
       public         heap    postgres    false            �            1259    33023    emprestimo_idemprestimo_seq    SEQUENCE     �   CREATE SEQUENCE public.emprestimo_idemprestimo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.emprestimo_idemprestimo_seq;
       public          postgres    false    227                       0    0    emprestimo_idemprestimo_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.emprestimo_idemprestimo_seq OWNED BY public.emprestimo.idemprestimo;
          public          postgres    false    226            �            1259    33036    emprestimo_livro    TABLE     j   CREATE TABLE public.emprestimo_livro (
    idemprestimo integer NOT NULL,
    idlivro integer NOT NULL
);
 $   DROP TABLE public.emprestimo_livro;
       public         heap    postgres    false            �            1259    32983    livro    TABLE     �   CREATE TABLE public.livro (
    idlivro integer NOT NULL,
    ideditora integer NOT NULL,
    idcategoria integer NOT NULL,
    nome character varying(70) NOT NULL
);
    DROP TABLE public.livro;
       public         heap    postgres    false            �            1259    33001    livro_autor    TABLE     `   CREATE TABLE public.livro_autor (
    idlivro integer NOT NULL,
    idautor integer NOT NULL
);
    DROP TABLE public.livro_autor;
       public         heap    postgres    false            �            1259    33055    livro_autor_info    VIEW     
  CREATE VIEW public.livro_autor_info AS
 SELECT liv.nome AS livro,
    aut.nome AS autor
   FROM ((public.livro liv
     LEFT JOIN public.livro_autor liv_aut ON ((liv.idlivro = liv_aut.idlivro)))
     LEFT JOIN public.autor aut ON ((aut.idautor = liv_aut.idautor)));
 #   DROP VIEW public.livro_autor_info;
       public          postgres    false    220    222    223    220    222    223            �            1259    32982    livro_idlivro_seq    SEQUENCE     �   CREATE SEQUENCE public.livro_idlivro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.livro_idlivro_seq;
       public          postgres    false    222                       0    0    livro_idlivro_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.livro_idlivro_seq OWNED BY public.livro.idlivro;
          public          postgres    false    221            �            1259    33051 
   livro_info    VIEW       CREATE VIEW public.livro_info AS
 SELECT liv.nome,
    cat.nome AS categoria,
    edt.nome AS editora
   FROM ((public.livro liv
     JOIN public.editora edt ON ((liv.ideditora = edt.ideditora)))
     JOIN public.categoria cat ON ((liv.idcategoria = cat.idcategoria)));
    DROP VIEW public.livro_info;
       public          postgres    false    218    216    216    218    222    222    222            G           2604    33020    aluno idaluno    DEFAULT     n   ALTER TABLE ONLY public.aluno ALTER COLUMN idaluno SET DEFAULT nextval('public.aluno_idaluno_seq'::regclass);
 <   ALTER TABLE public.aluno ALTER COLUMN idaluno DROP DEFAULT;
       public          postgres    false    225    224    225            E           2604    32943    autor idautor    DEFAULT     n   ALTER TABLE ONLY public.autor ALTER COLUMN idautor SET DEFAULT nextval('public.autor_idautor_seq'::regclass);
 <   ALTER TABLE public.autor ALTER COLUMN idautor DROP DEFAULT;
       public          postgres    false    219    220    220            D           2604    32934    categoria idcategoria    DEFAULT     ~   ALTER TABLE ONLY public.categoria ALTER COLUMN idcategoria SET DEFAULT nextval('public.categoria_idcategoria_seq'::regclass);
 D   ALTER TABLE public.categoria ALTER COLUMN idcategoria DROP DEFAULT;
       public          postgres    false    217    218    218            C           2604    32925    editora ideditora    DEFAULT     v   ALTER TABLE ONLY public.editora ALTER COLUMN ideditora SET DEFAULT nextval('public.editora_ideditora_seq'::regclass);
 @   ALTER TABLE public.editora ALTER COLUMN ideditora DROP DEFAULT;
       public          postgres    false    216    215    216            H           2604    33027    emprestimo idemprestimo    DEFAULT     �   ALTER TABLE ONLY public.emprestimo ALTER COLUMN idemprestimo SET DEFAULT nextval('public.emprestimo_idemprestimo_seq'::regclass);
 F   ALTER TABLE public.emprestimo ALTER COLUMN idemprestimo DROP DEFAULT;
       public          postgres    false    226    227    227            F           2604    32986    livro idlivro    DEFAULT     n   ALTER TABLE ONLY public.livro ALTER COLUMN idlivro SET DEFAULT nextval('public.livro_idlivro_seq'::regclass);
 <   ALTER TABLE public.livro ALTER COLUMN idlivro DROP DEFAULT;
       public          postgres    false    221    222    222                      0    33017    aluno 
   TABLE DATA           .   COPY public.aluno (idaluno, nome) FROM stdin;
    public          postgres    false    225   xJ       �          0    32940    autor 
   TABLE DATA           .   COPY public.autor (idautor, nome) FROM stdin;
    public          postgres    false    220   �J       �          0    32931 	   categoria 
   TABLE DATA           6   COPY public.categoria (idcategoria, nome) FROM stdin;
    public          postgres    false    218   �K       �          0    32922    editora 
   TABLE DATA           2   COPY public.editora (ideditora, nome) FROM stdin;
    public          postgres    false    216   �K                 0    33024 
   emprestimo 
   TABLE DATA           n   COPY public.emprestimo (idemprestimo, idaluno, data_emprestimo, data_devolucao, valor, devolvido) FROM stdin;
    public          postgres    false    227   L                 0    33036    emprestimo_livro 
   TABLE DATA           A   COPY public.emprestimo_livro (idemprestimo, idlivro) FROM stdin;
    public          postgres    false    228   �L       �          0    32983    livro 
   TABLE DATA           F   COPY public.livro (idlivro, ideditora, idcategoria, nome) FROM stdin;
    public          postgres    false    222   �L                  0    33001    livro_autor 
   TABLE DATA           7   COPY public.livro_autor (idlivro, idautor) FROM stdin;
    public          postgres    false    223   �M                  0    0    aluno_idaluno_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.aluno_idaluno_seq', 5, true);
          public          postgres    false    224                       0    0    autor_idautor_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.autor_idautor_seq', 10, true);
          public          postgres    false    219                       0    0    categoria_idcategoria_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.categoria_idcategoria_seq', 4, true);
          public          postgres    false    217                       0    0    editora_ideditora_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.editora_ideditora_seq', 4, true);
          public          postgres    false    215                       0    0    emprestimo_idemprestimo_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.emprestimo_idemprestimo_seq', 7, true);
          public          postgres    false    226                       0    0    livro_idlivro_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.livro_idlivro_seq', 8, true);
          public          postgres    false    221            [           2606    33022    aluno aluno_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.aluno
    ADD CONSTRAINT aluno_pkey PRIMARY KEY (idaluno);
 :   ALTER TABLE ONLY public.aluno DROP CONSTRAINT aluno_pkey;
       public            postgres    false    225            ]           2606    33030    emprestimo emprestimo_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.emprestimo
    ADD CONSTRAINT emprestimo_pkey PRIMARY KEY (idemprestimo);
 D   ALTER TABLE ONLY public.emprestimo DROP CONSTRAINT emprestimo_pkey;
       public            postgres    false    227            U           2606    32990    livro livro_nome_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_nome_key UNIQUE (nome);
 >   ALTER TABLE ONLY public.livro DROP CONSTRAINT livro_nome_key;
       public            postgres    false    222            W           2606    32988    livro livro_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.livro
    ADD CONSTRAINT livro_pkey PRIMARY KEY (idlivro);
 :   ALTER TABLE ONLY public.livro DROP CONSTRAINT livro_pkey;
       public            postgres    false    222            S           2606    32945    autor pk_aut_idautor 
   CONSTRAINT     W   ALTER TABLE ONLY public.autor
    ADD CONSTRAINT pk_aut_idautor PRIMARY KEY (idautor);
 >   ALTER TABLE ONLY public.autor DROP CONSTRAINT pk_aut_idautor;
       public            postgres    false    220            O           2606    32936    categoria pk_cat_idcategoria 
   CONSTRAINT     c   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT pk_cat_idcategoria PRIMARY KEY (idcategoria);
 F   ALTER TABLE ONLY public.categoria DROP CONSTRAINT pk_cat_idcategoria;
       public            postgres    false    218            K           2606    32927    editora pk_edt_ideditora 
   CONSTRAINT     ]   ALTER TABLE ONLY public.editora
    ADD CONSTRAINT pk_edt_ideditora PRIMARY KEY (ideditora);
 B   ALTER TABLE ONLY public.editora DROP CONSTRAINT pk_edt_ideditora;
       public            postgres    false    216            Y           2606    33005 "   livro_autor pk_livaut_idlivroautor 
   CONSTRAINT     n   ALTER TABLE ONLY public.livro_autor
    ADD CONSTRAINT pk_livaut_idlivroautor PRIMARY KEY (idlivro, idautor);
 L   ALTER TABLE ONLY public.livro_autor DROP CONSTRAINT pk_livaut_idlivroautor;
       public            postgres    false    223    223            Q           2606    32938    categoria un_cat_nome 
   CONSTRAINT     P   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT un_cat_nome UNIQUE (nome);
 ?   ALTER TABLE ONLY public.categoria DROP CONSTRAINT un_cat_nome;
       public            postgres    false    218            M           2606    32929    editora un_edt_nome 
   CONSTRAINT     N   ALTER TABLE ONLY public.editora
    ADD CONSTRAINT un_edt_nome UNIQUE (nome);
 =   ALTER TABLE ONLY public.editora DROP CONSTRAINT un_edt_nome;
       public            postgres    false    216            ^           1259    33050    idx_emp_data_devolucao    INDEX     W   CREATE INDEX idx_emp_data_devolucao ON public.emprestimo USING btree (data_devolucao);
 *   DROP INDEX public.idx_emp_data_devolucao;
       public            postgres    false    227            _           1259    33049    idx_emp_data_emprestimo    INDEX     Y   CREATE INDEX idx_emp_data_emprestimo ON public.emprestimo USING btree (data_emprestimo);
 +   DROP INDEX public.idx_emp_data_emprestimo;
       public            postgres    false    227            e           2606    33039 3   emprestimo_livro emprestimo_livro_idemprestimo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.emprestimo_livro
    ADD CONSTRAINT emprestimo_livro_idemprestimo_fkey FOREIGN KEY (idemprestimo) REFERENCES public.emprestimo(idemprestimo);
 ]   ALTER TABLE ONLY public.emprestimo_livro DROP CONSTRAINT emprestimo_livro_idemprestimo_fkey;
       public          postgres    false    228    227    4701            f           2606    33044 .   emprestimo_livro emprestimo_livro_idlivro_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.emprestimo_livro
    ADD CONSTRAINT emprestimo_livro_idlivro_fkey FOREIGN KEY (idlivro) REFERENCES public.livro(idlivro);
 X   ALTER TABLE ONLY public.emprestimo_livro DROP CONSTRAINT emprestimo_livro_idlivro_fkey;
       public          postgres    false    4695    222    228            d           2606    33031    emprestimo fk_emp_idaluno    FK CONSTRAINT     }   ALTER TABLE ONLY public.emprestimo
    ADD CONSTRAINT fk_emp_idaluno FOREIGN KEY (idaluno) REFERENCES public.aluno(idaluno);
 C   ALTER TABLE ONLY public.emprestimo DROP CONSTRAINT fk_emp_idaluno;
       public          postgres    false    4699    225    227            `           2606    32996    livro fk_liv_idcategoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.livro
    ADD CONSTRAINT fk_liv_idcategoria FOREIGN KEY (idcategoria) REFERENCES public.categoria(idcategoria);
 B   ALTER TABLE ONLY public.livro DROP CONSTRAINT fk_liv_idcategoria;
       public          postgres    false    218    4687    222            a           2606    32991    livro fk_liv_ideditora    FK CONSTRAINT     �   ALTER TABLE ONLY public.livro
    ADD CONSTRAINT fk_liv_ideditora FOREIGN KEY (ideditora) REFERENCES public.editora(ideditora);
 @   ALTER TABLE ONLY public.livro DROP CONSTRAINT fk_liv_ideditora;
       public          postgres    false    4683    222    216            b           2606    33011    livro_autor fk_livaut_idautor    FK CONSTRAINT     �   ALTER TABLE ONLY public.livro_autor
    ADD CONSTRAINT fk_livaut_idautor FOREIGN KEY (idautor) REFERENCES public.autor(idautor);
 G   ALTER TABLE ONLY public.livro_autor DROP CONSTRAINT fk_livaut_idautor;
       public          postgres    false    4691    223    220            c           2606    33006    livro_autor fk_livaut_idlivro    FK CONSTRAINT     �   ALTER TABLE ONLY public.livro_autor
    ADD CONSTRAINT fk_livaut_idlivro FOREIGN KEY (idlivro) REFERENCES public.livro(idlivro);
 G   ALTER TABLE ONLY public.livro_autor DROP CONSTRAINT fk_livaut_idlivro;
       public          postgres    false    222    4695    223               2   x�3��M,���2���?�8�˘3 �4'�˄3 5�(��,������ 1,r      �   �   x��MjAF�U��H����������MiZP��3C�m<@N��ҫ��7�=[���Z�8���o�:��!���L{�g|�fPj���Zν|�e�\���h0%�F��$�+�!i�_Z��O�������Sx�a��%1��+�s�m��;\���q�;��7�Z?N`�GsZ���MD��Ds      �   2   x�3�tJ�K�WHIUpIL�/�2�����2��J,K�2�������� �q
5      �   @   x�3�t����M��2�tMIO,JQp�)-�H-�2���/KTI-*J�2�t*J,.�/*����� �=�         c   x�uα� ����~p`�4i��	"�4�^��m��jL�I���Y�p��X� ������0NQQ~D�75�=�þ#�.Z�gG�E�矗�YD��'�         -   x��9 0��Lf�L��52�\A�א*j���]�>}�w      �   �   x�u�AJ1E��)�
i{T��82�(݈�75��tRM�����k�Ŭ�jW�������Q+��#Xc�	N��M���uэj"ھ�W������.��#��*�F~���]�f?�GJ@nqD]���DGA@�e�f�9X�A����w�ospm�޳���ŪR�E��-���S������aM������1�'���Y�v��Oɯ{��〽�������x�f�F�B��j���{          /   x���  ��w2�P�]��� ��n'M�?,'��q�[��0�     