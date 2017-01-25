/*==============================================================*/
/* Table: GRUPO_ECONOMICO                                       */
/*==============================================================*/
create table GRUPO_ECONOMICO (
   GRUPO_ECONOMICO_ID   numeric(3)                     not null,
   NOMBRE               varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_GRUPO_ECONOMICO unique (GRUPO_ECONOMICO_ID) )
   ;

/*==============================================================*/
/* Table: EMPRESA                                               */
/*==============================================================*/
create table EMPRESA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA400),
   SIGLA                varchar(30)                    null
      check (SIGLA is null or (ASA401)),
   NOMBRE               varchar(60)                    null,
   GRUPO_ECONOMICO_ID   numeric(3)                     null,
   TIPO_EMPRESA_ID      numeric(3)                     null default 0
      check (TIPO_EMPRESA_ID is null or (ASA402)),
   tiene_errores        tinyint                        not null default 0,
   constraint PK_EMPRESA unique (EMPRESA_ID),
   foreign key FK_EMPRESA_ASSOCIATI_GRUPO_EC (GRUPO_ECONOMICO_ID)
         references GRUPO_ECONOMICO (GRUPO_ECONOMICO_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ALIMENTADOR                                           */
/*==============================================================*/
create table ALIMENTADOR (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA233),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA234),
   PERIODO_STAR_ID      integer                        not null
      check (ASA235),
   ALIMENTADOR_ID       numeric(10)                    not null
      check (ASA236),
   NOMBRE_ALIMENTADOR   varchar(60)                    null
      check (NOMBRE_ALIMENTADOR is null or (ASA237)),
   TENSION_NOMINAL      numeric(4,1)                   null
      check (TENSION_NOMINAL is null or (ASA238)),
   I_MAX                numeric(10,2)                  null
      check (I_MAX is null or (ASA239)),
   FH_I_MAX             timestamp                      null
      check (FH_I_MAX is null or (ASA240)),
   RECONEXION_AUTOMATICA numeric(1)                     null
      check (RECONEXION_AUTOMATICA is null or (ASA241)),
   REGULADOR_TENSION    numeric(1)                     null
      check (REGULADOR_TENSION is null or (ASA242)),
   RELE_BAJA_FRECUENCIA numeric(1)                     null
      check (RELE_BAJA_FRECUENCIA is null or (ASA243)),
   FRECUENCIA_RELE      numeric(5,2)                   null
      check (FRECUENCIA_RELE is null or (ASA244)),
   I_CC_TRIFASICO_CABECERA numeric(10,2)                  null
      check (I_CC_TRIFASICO_CABECERA is null or (ASA245)),
   CLIENTES_BT1         numeric(10)                    null
      check (CLIENTES_BT1 is null or (ASA246)),
   CLIENTES_OTROS_BT    numeric(10)                    null
      check (CLIENTES_OTROS_BT is null or (ASA247)),
   CLIENTES_AT          numeric(10)                    null
      check (CLIENTES_AT is null or (ASA248)),
   CLIENTES_LIBRES      numeric(10)                    null
      check (CLIENTES_LIBRES is null or (ASA249)),
   KVA_INSTALADOS_U     numeric(10,2)                  null
      check (KVA_INSTALADOS_U is null or (ASA250)),
   KVA_INSTALADOS_R1    numeric(10,2)                  null
      check (KVA_INSTALADOS_R1 is null or (ASA251)),
   ES_SUBALIMENTADOR    numeric(1)                     null
      check (ES_SUBALIMENTADOR is null or (ASA252)),
   EMPRESA_SUMINISTRADORA_ID numeric(3)                     null,
   ALIMENTADOR_SUMINISTRADOR_ID numeric(10)                    null,
   PEEM_ID              numeric(10)                    null,
   KVA_INSTALADOS_R2    numeric(10,2)                  null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ALIMENTADOR unique (EMPRESA_ID, PERIODO_STAR, ALIMENTADOR_ID),
   foreign key FK_ALIMENTA_EMPRES1 (EMPRESA_SUMINISTRADORA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_EMPRESA_ALIMENTADO1 (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: INCIDENCIA                                            */
/*==============================================================*/
create table INCIDENCIA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA506),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA507),
   PERIODO_STAR_ID      integer                        not null
      check (ASA508),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA509),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_INCIDENCIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID),
   foreign key FK_INCIDENC_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ALIMENTADOR_INCIDENCIA                                */
/*==============================================================*/
create table ALIMENTADOR_INCIDENCIA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA264),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA265),
   PERIODO_STAR_ID      integer                        not null
      check (ASA266),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA267),
   ALIMENTADOR_ID       numeric(10)                    not null
      check (ASA268),
   NOMBRE_ALIMENTADOR   varchar(60)                    null
      check (NOMBRE_ALIMENTADOR is null or (ASA269)),
   TENSION_NOMINAL      numeric(4,1)                   null
      check (TENSION_NOMINAL is null or (ASA270)),
   I_MAX                numeric(10,2)                  null
      check (I_MAX is null or (ASA271)),
   FH_I_MAX             timestamp                      null
      check (FH_I_MAX is null or (ASA272)),
   RECONEXION_AUTOMATICA numeric(1)                     null
      check (RECONEXION_AUTOMATICA is null or (ASA273)),
   REGULADOR_TENSION    numeric(1)                     null
      check (REGULADOR_TENSION is null or (ASA274)),
   RELE_BAJA_FRECUENCIA numeric(1)                     null
      check (RELE_BAJA_FRECUENCIA is null or (ASA275)),
   FRECUENCIA_RELE      numeric(5,2)                   null
      check (FRECUENCIA_RELE is null or (ASA276)),
   I_CC_TRIFASICO_CABECERA numeric(10,2)                  null
      check (I_CC_TRIFASICO_CABECERA is null or (ASA277)),
   CLIENTES_BT1         numeric(10)                    null
      check (CLIENTES_BT1 is null or (ASA278)),
   CLIENTES_OTROS_BT    numeric(10)                    null
      check (CLIENTES_OTROS_BT is null or (ASA279)),
   CLIENTES_AT          numeric(10)                    null
      check (CLIENTES_AT is null or (ASA280)),
   CLIENTES_LIBRES      numeric(10)                    null
      check (CLIENTES_LIBRES is null or (ASA281)),
   ES_SUBALIMENTADOR    numeric(1)                     null
      check (ES_SUBALIMENTADOR is null or (ASA282)),
   ALIMENTADOR_SUMINISTRADOR_ID numeric(10)                    null,
   EMPRESA_SUMINISTRADORA_ID numeric(3)                     null,
   KVA_INSTALADOS_U     numeric(10,2)                  null
      check (KVA_INSTALADOS_U is null or (ASA283)),
   KVA_INSTALADOS_R1    numeric(10,2)                  null
      check (KVA_INSTALADOS_R1 is null or (ASA284)),
   PEEM_ID              numeric(10)                    null,
   KVA_INSTALADOS_R2    numeric(10,2)                  null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ALIMENTADOR_INCIDENCIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID),
   foreign key FK_ALIMENTA_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_ALIMENTA_EMPRESA (EMPRESA_SUMINISTRADORA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: SISTEMA_ELECTRICO                                     */
/*==============================================================*/
create table SISTEMA_ELECTRICO (
   SISTEMA_ELECTRICO_ID numeric(10)                    not null
      check (ASA696),
   EMPRESA_ID           numeric(3)                     null
      check (EMPRESA_ID is null or (ASA697)),
   NOMBRE               varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_SISTEMA_ELECTRICO unique (SISTEMA_ELECTRICO_ID),
   foreign key FK_SISTEMA__EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_NODO                                             */
/*==============================================================*/
create table TIPO_NODO (
   TIPO_NODO_ID         numeric(2)                     not null
      check (ASA726),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_NODO unique (TIPO_NODO_ID) )
   ;

/*==============================================================*/
/* Table: DATUM                                                 */
/*==============================================================*/
create table DATUM (
   DATUM_ID             numeric(2)                     not null
      check (ASA380),
   NOMBRE               varchar(60)                    null
      check (NOMBRE is null or (ASA381)),
   tiene_errores        tinyint                        not null default 0,
   constraint PK_DATUM unique (DATUM_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_INSTALACION_INCIDENCIA                           */
/*==============================================================*/
create table TIPO_INSTALACION_INCIDENCIA (
   TIPO_INSTALACION_INCIDENCIA_ID numeric(2)                     not null
      check (ASA725),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_INSTALACION_INCIDENCIA unique (TIPO_INSTALACION_INCIDENCIA_ID) )
   ;

/*==============================================================*/
/* Table: ZONA_UTM                                              */
/*==============================================================*/
create table ZONA_UTM (
   ZONA_UTM             numeric(2)                     not null
      check (ASA811),
   constraint PK_ZONA_UTM unique (ZONA_UTM) )
   ;

/*==============================================================*/
/* Table: NODO_INCIDENCIA                                       */
/*==============================================================*/
create table NODO_INCIDENCIA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA587),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA588),
   PERIODO_STAR_ID      integer                        not null
      check (ASA589),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA590),
   NODO_INCIDENCIA_ID   numeric(15)                    not null
      check (ASA591),
   TIPO_INSTALACION_INCIDENCIA_ID numeric(2)                     null
      check (TIPO_INSTALACION_INCIDENCIA_ID is null or (ASA592)),
   ALIMENTADOR_ID       numeric(10)                    null
      check (ALIMENTADOR_ID is null or (ASA593)),
   DATUM_ID             numeric(2)                     null
      check (DATUM_ID is null or (ASA594)),
   TIPO_NODO_ID         numeric(2)                     null
      check (TIPO_NODO_ID is null or (ASA595)),
   X                    numeric(15,3)                  null
      check (X is null or (ASA596)),
   Y                    numeric(15,3)                  null
      check (Y is null or (ASA597)),
   ZONA_UTM             numeric(2)                     null
      check (ZONA_UTM is null or (ASA598)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NODO_INCIDENCIA unique (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID),
   foreign key FK_NODO_INC_TIPO_NOD (TIPO_NODO_ID)
         references TIPO_NODO (TIPO_NODO_ID)
         on update restrict,
   foreign key FK_NODO_INC_DATUM (DATUM_ID)
         references DATUM (DATUM_ID)
         on update restrict,
   foreign key FK_NODO_INC_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_NODO_INC_TIPO_INS (TIPO_INSTALACION_INCIDENCIA_ID)
         references TIPO_INSTALACION_INCIDENCIA (TIPO_INSTALACION_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_NODO_INC_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_NODO_INC_REFERENCE_ZONA_UTM (ZONA_UTM)
         references ZONA_UTM (ZONA_UTM)
         on update restrict,
   foreign key FK_NODO_INC_ALIMENTA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID)
         references ALIMENTADOR_INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_EFECTO_EVENTO                                    */
/*==============================================================*/
create table TIPO_EFECTO_EVENTO (
   TIPO_EFECTO_EVENTO_ID numeric(2)                     not null
      check (ASA716),
   DESCRIPCION          varchar(60)                    null
      check (DESCRIPCION is null or (ASA717)),
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_EFECTO_EVENTO unique (TIPO_EFECTO_EVENTO_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_EVENTO_RED                                       */
/*==============================================================*/
create table TIPO_EVENTO_RED (
   TIPO_EVENTO_ID       numeric(2)                     not null
      check (ASA721),
   DESCRIPCION          varchar(100)                   null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_EVENTO_RED unique (TIPO_EVENTO_ID) )
   ;

/*==============================================================*/
/* Table: EVENTO_RED                                            */
/*==============================================================*/
create table EVENTO_RED (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA481),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA482),
   PERIODO_STAR_ID      integer                        not null
      check (ASA483),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA484),
   EVENTORED_ID         numeric(10)                    not null
      check (ASA485),
   NODO_INCIDENCIA_ID   numeric(15)                    null
      check (NODO_INCIDENCIA_ID is null or (ASA486)),
   TIPO_EFECTO_EVENTO_ID numeric(2)                     null
      check (TIPO_EFECTO_EVENTO_ID is null or (ASA487)),
   TIPO_EVENTO_ID       numeric(2)                     null
      check (TIPO_EVENTO_ID is null or (ASA488)),
   FECHA_EVENTO         timestamp                      null
      check (FECHA_EVENTO is null or (ASA489)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_EVENTO_RED unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID),
   foreign key FK_EVENTO_R_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_EVENTO_R_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_EVENTO_R_TIPO_EFE (TIPO_EFECTO_EVENTO_ID)
         references TIPO_EFECTO_EVENTO (TIPO_EFECTO_EVENTO_ID)
         on update restrict,
   foreign key FK_EVENTO_R_TIPO_EVE (TIPO_EVENTO_ID)
         references TIPO_EVENTO_RED (TIPO_EVENTO_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_ORIGEN_INTERRUPCION                              */
/*==============================================================*/
create table TIPO_ORIGEN_INTERRUPCION (
   TIPO_ORIGEN_INTERRUPCION_ID numeric(2)                     not null
      check (ASA727),
   DESCRIPCION          varchar(101)                   null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_ORIGEN_INTERRUPCION unique (TIPO_ORIGEN_INTERRUPCION_ID) )
   ;

/*==============================================================*/
/* Table: CALIFICACION_INTERRUPCION                             */
/*==============================================================*/
create table CALIFICACION_INTERRUPCION (
   CALIFICACION_INTERRUPCION_ID numeric(2)                     not null
      check (ASA336),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_CALIFICACION_INTERRUPCION unique (CALIFICACION_INTERRUPCION_ID) )
   ;

/*==============================================================*/
/* Table: CAUSA                                                 */
/*==============================================================*/
create table CAUSA (
   CAUSA_ID             numeric(5)                     not null
      check (ASA358),
   CLASIFICACION        varchar(100)                   null
      check (CLASIFICACION is null or (ASA359)),
   DESCRIPCION          varchar(100)                   null
      check (DESCRIPCION is null or (ASA360)),
   CALIFICACION_INTERRUPCION_ID numeric(2)                     null
      check (CALIFICACION_INTERRUPCION_ID is null or (ASA361)),
   tiene_errores        tinyint                        not null default 0,
   constraint PK_CAUSA unique (CAUSA_ID),
   foreign key FK_CAUSA_CALIFICA (CALIFICACION_INTERRUPCION_ID)
         references CALIFICACION_INTERRUPCION (CALIFICACION_INTERRUPCION_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: INTERRUPCION                                          */
/*==============================================================*/
create table INTERRUPCION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA515),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA516),
   PERIODO_STAR_ID      integer                        not null
      check (ASA517),
   INTERRUPCION_ID      varchar(18)                    not null
      check (ASA518),
   CALIFICACION_INTERRUPCION_ID numeric(2)                     null
      check (CALIFICACION_INTERRUPCION_ID is null or (ASA519)),
   TIPO_ORIGEN_INTERRUPCION_ID numeric(2)                     null
      check (TIPO_ORIGEN_INTERRUPCION_ID is null or (ASA520)),
   SISTEMA_ELECTRICO_ID numeric(10)                    null
      check (SISTEMA_ELECTRICO_ID is null or (ASA521)),
   CAUSA_ID             numeric(5)                     null
      check (CAUSA_ID is null or (ASA522)),
   INCIDENCIA_ID        numeric(10)                    null
      check (INCIDENCIA_ID is null or (ASA523)),
   EVENTORED_ID         numeric(10)                    null
      check (EVENTORED_ID is null or (ASA524)),
   EMPRESA_SUMINISTRADORA_ID numeric(3)                     null,
   INTERRUPCION_SUMINISTRADORA_ID varchar(18)                    null,
   FH_INICIO_INTERRUPCION timestamp                      null
      check (FH_INICIO_INTERRUPCION is null or (ASA525)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_INTERRUPCION unique (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID),
   foreign key FK_INTERRUP_SISTEMA_ (SISTEMA_ELECTRICO_ID)
         references SISTEMA_ELECTRICO (SISTEMA_ELECTRICO_ID)
         on update restrict,
   foreign key FK_EMPRESA_INTERRUPCIO1 (EMPRESA_SUMINISTRADORA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_INTERRUP_EVENTO_R (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID)
         references EVENTO_RED (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID)
         on update restrict,
   foreign key FK_INTERRUP_TIPO_ORI (TIPO_ORIGEN_INTERRUPCION_ID)
         references TIPO_ORIGEN_INTERRUPCION (TIPO_ORIGEN_INTERRUPCION_ID)
         on update restrict,
   foreign key FK_INTERRUP_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_INTERRUP_CALIFICA (CALIFICACION_INTERRUPCION_ID)
         references CALIFICACION_INTERRUPCION (CALIFICACION_INTERRUPCION_ID)
         on update restrict,
   foreign key FK_INTERRUP_CAUSA (CAUSA_ID)
         references CAUSA (CAUSA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ALIMENTADOR_AFECTADO                                  */
/*==============================================================*/
create table ALIMENTADOR_AFECTADO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA253),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA254),
   PERIODO_STAR_ID      integer                        not null
      check (ASA255),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA256),
   ALIMENTADOR_ID       numeric(10)                    not null
      check (ASA257),
   INTERRUPCION_ID      varchar(18)                    not null
      check (ASA258),
   KVA_INTERRUMPIDOS_U  numeric(10,2)                  null
      check (KVA_INTERRUMPIDOS_U is null or (ASA259)),
   KVA_INTERRUMPIDOS_R1 numeric(10,2)                  null
      check (KVA_INTERRUMPIDOS_R1 is null or (ASA260)),
   TOTAL_TRANFO_INT_U   numeric(10)                    null
      check (TOTAL_TRANFO_INT_U is null or (ASA261)),
   TOTAL_CLIENTES_INT   numeric(10)                    null
      check (TOTAL_CLIENTES_INT is null or (ASA262)),
   TOTAL_TRAFO_INT_R1   numeric(10)                    null
      check (TOTAL_TRAFO_INT_R1 is null or (ASA263)),
   PEEM_ID              numeric(10)                    null,
   KVA_INTERRUMPIDOS_R2 numeric(10,2)                  null,
   TOTAL_TRAFO_INT_R2   numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ALIMENTADOR_AFECTADO unique (INCIDENCIA_ID, ALIMENTADOR_ID, EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID),
   foreign key FK_ALIMENTA_ALIMENTA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID)
         references ALIMENTADOR_INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID)
         on update restrict,
   foreign key FK_INTERRUPCION_ALIMENTADOR_1 (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID)
         references INTERRUPCION (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: BLOQUE_REPOSICION                                     */
/*==============================================================*/
create table BLOQUE_REPOSICION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA315),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA316),
   PERIODO_STAR_ID      integer                        not null
      check (ASA317),
   INTERRUPCION_ID      varchar(18)                    not null
      check (ASA318),
   BLOQUE_REPOSICION_ID numeric(10)                    not null
      check (ASA319),
   INCIDENCIA_ID        numeric(10)                    null
      check (INCIDENCIA_ID is null or (ASA320)),
   EVENTORED_ID         numeric(10)                    null
      check (EVENTORED_ID is null or (ASA321)),
   DURACION             numeric(10)                    null
      check (DURACION is null or (ASA322)),
   FH_TERMINO_BLOQUE    timestamp                      null
      check (FH_TERMINO_BLOQUE is null or (ASA323)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_BLOQUE_REPOSICION unique (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID, BLOQUE_REPOSICION_ID),
   foreign key FK_BLOQUE_R_EVENTO_R (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID)
         references EVENTO_RED (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID)
         on update restrict,
   foreign key FK_INTERRUPCION_BLOQUE_REPOS1 (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID)
         references INTERRUPCION (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ALIMENTADOR_REPOSICION                                */
/*==============================================================*/
create table ALIMENTADOR_REPOSICION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA285),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA286),
   PERIODO_STAR_ID      integer                        not null
      check (ASA287),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA288),
   ALIMENTADOR_ID       numeric(10)                    not null
      check (ASA289),
   INTERRUPCION_ID      varchar(18)                    not null
      check (ASA290),
   BLOQUE_REPOSICION_ID numeric(10)                    not null
      check (ASA291),
   KVA_REPUESTOS_R1     numeric(10,2)                  null
      check (KVA_REPUESTOS_R1 is null or (ASA292)),
   KVA_REPUESTOS_U      numeric(10,2)                  null
      check (KVA_REPUESTOS_U is null or (ASA293)),
   PEEM_ID              numeric(10)                    null,
   KVA_REPUESTOS_R2     numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ALIMENTADOR_REPOSICION unique (EMPRESA_ID, INTERRUPCION_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID, BLOQUE_REPOSICION_ID),
   foreign key FK_ALIMENTA_ALIMENT1 (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID)
         references ALIMENTADOR_INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, ALIMENTADOR_ID)
         on update restrict,
   foreign key FK_ALIMENTA_BLOQUE_R (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID, BLOQUE_REPOSICION_ID)
         references BLOQUE_REPOSICION (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID, BLOQUE_REPOSICION_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ALIMENTADOR_UNICO_ID                                  */
/*==============================================================*/
create table ALIMENTADOR_UNICO_ID (
   EMPRESA_ID           numeric(3)                     not null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA294),
   UNIQUE_ID            numeric                        not null,
   NOMBRE               varchar(150)                   not null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ALIMENTADOR_UNICO_ID unique (EMPRESA_ID, ALIMENTADOR_ID, PERIODO_STAR, UNIQUE_ID, NOMBRE) )
   ;

/*==============================================================*/
/* Table: ARCHIVO_STAR                                          */
/*==============================================================*/
create table ARCHIVO_STAR (
   NOMBRE               varchar(255)                   null
      check (NOMBRE is null or (ASA295)),
   MODULO               varchar(5)                     null,
   OBLIGATORIO          numeric                        null default 1,
   TABLA                varchar(30)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TIPO_AVISO                                            */
/*==============================================================*/
create table TIPO_AVISO (
   TIPO_AVISO_ID        numeric(2)                     not null
      check (ASA712),
   DESCRIPCION          varchar(100)                   null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_AVISO unique (TIPO_AVISO_ID) )
   ;

/*==============================================================*/
/* Table: AVISO                                                 */
/*==============================================================*/
create table AVISO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA296),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA297),
   PERIODO_STAR_ID      integer                        not null
      check (ASA298),
   INTERRUPCION_ID      varchar(18)                    not null
      check (ASA299),
   AVISO_ID             numeric(10)                    not null
      check (ASA300),
   TIPO_AVISO_ID        numeric(2)                     null
      check (TIPO_AVISO_ID is null or (ASA301)),
   PUNTO_SUMINISTRO_ID  varchar(30)                    null,
   DESCRIPCION_AVISO    varchar(200)                   null
      check (DESCRIPCION_AVISO is null or (ASA302)),
   PRESENTACION_ID      varchar(25)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_AVISO unique (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID, AVISO_ID),
   foreign key FK_AVISO_TIPO_AVI (TIPO_AVISO_ID)
         references TIPO_AVISO (TIPO_AVISO_ID)
         on update restrict,
   foreign key FK_INTERRUPCION_AVISO1 (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID)
         references INTERRUPCION (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: A_TRAFOS_ASOC_ALIM                                    */
/*==============================================================*/
create table A_TRAFOS_ASOC_ALIM (
   TRANSFORMADOR_ID     numeric(10)                    not null,
   NODO_IEC_ID          numeric(15)                    not null,
   ORIGEN_NODO_IEC_ID   numeric(15)                    null,
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA303),
   ALIMENTADOR_ID       numeric                        null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   KVA                  numeric(12,2)                  null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TIPO_INSTALACION                                      */
/*==============================================================*/
create table TIPO_INSTALACION (
   TIPO_INSTALACION_ID  numeric(2)                     not null
      check (ASA723),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_INSTALACION unique (TIPO_INSTALACION_ID) )
   ;

/*==============================================================*/
/* Table: NODO_IEC                                              */
/*==============================================================*/
create table NODO_IEC (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA556),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA557),
   PERIODO_STAR_ID      integer                        not null
      check (ASA558),
   NODO_IEC_ID          numeric(15)                    not null
      check (ASA559),
   DATUM_ID             numeric(2)                     null
      check (DATUM_ID is null or (ASA560)),
   TIPO_NODO_ID         numeric(2)                     null
      check (TIPO_NODO_ID is null or (ASA561)),
   TIPO_INSTALACION_ID  numeric(2)                     null
      check (TIPO_INSTALACION_ID is null or (ASA562)),
   ALIMENTADOR_ID       numeric(10)                    null
      check (ALIMENTADOR_ID is null or (ASA563)),
   X                    numeric(15,3)                  null
      check (X is null or (ASA564)),
   Y                    numeric(15,3)                  null
      check (Y is null or (ASA565)),
   ZONA_UTM             numeric(2)                     null
      check (ZONA_UTM is null or (ASA566)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NODO_IEC unique (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR),
   foreign key FK_NODO_IEC_EMPRES1 (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_NODO_IEC_REFERENCE_ZONA_UTM (ZONA_UTM)
         references ZONA_UTM (ZONA_UTM)
         on update restrict,
   foreign key FK_NODO_IEC_TIPO_INS (TIPO_INSTALACION_ID)
         references TIPO_INSTALACION (TIPO_INSTALACION_ID)
         on update restrict,
   foreign key FK_NODO_IEC_TIPO_NOD (TIPO_NODO_ID)
         references TIPO_NODO (TIPO_NODO_ID)
         on update restrict,
   foreign key FK_NODO_IEC_DATUM (DATUM_ID)
         references DATUM (DATUM_ID)
         on update restrict,
   foreign key FK_NODO_IEC_ALIMENTA (EMPRESA_ID, PERIODO_STAR, ALIMENTADOR_ID)
         references ALIMENTADOR (EMPRESA_ID, PERIODO_STAR, ALIMENTADOR_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: COMUNA                                                */
/*==============================================================*/
create table COMUNA (
   COMUNA_ID            numeric(7)                     not null
      check (ASA365),
   NOMBRE               varchar(60)                    null
      check (NOMBRE is null or (ASA366)),
   PROVINCIA            varchar(60)                    null,
   REGION               varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_COMUNA unique (COMUNA_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_PROPIEDAD                                        */
/*==============================================================*/
create table TIPO_PROPIEDAD (
   TIPO_PROPIEDAD_ID    numeric(2)                     not null
      check (ASA728),
   DESCRICPION          varchar(100)                   null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_PROPIEDAD unique (TIPO_PROPIEDAD_ID) )
   ;

/*==============================================================*/
/* Table: BAJADA                                                */
/*==============================================================*/
create table BAJADA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA304),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA305),
   PERIODO_STAR_ID      integer                        not null
      check (ASA306),
   BAJADA_ID            numeric(10)                    not null
      check (ASA307),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA308)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA309)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA310)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA311)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA312)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA313)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_BAJADA unique (EMPRESA_ID, PERIODO_STAR, BAJADA_ID),
   foreign key FK_BAJADA_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_BAJADA_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_BAJADA_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_BAJADA_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: BCK_FBG_RESUMEN_CARGA                                 */
/*==============================================================*/
create table BCK_FBG_RESUMEN_CARGA (
   EMPRESA_ID           numeric                        null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA314),
   TABLA                varchar(30)                    null,
   REGISTROS_TEXTO      numeric                        null,
   REGISTROS_CARGADOS   numeric                        null,
   REGISTROS_RECHAZADOS numeric                        null,
   FECHA_INICIO         timestamp                      null,
   FECHA_TERMINO        timestamp                      null,
   NOMBRE_ARCHIVO       varchar(255)                   null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: BOVEDA                                                */
/*==============================================================*/
create table BOVEDA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA324),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA325),
   PERIODO_STAR_ID      integer                        not null
      check (ASA326),
   BOVEDA_ID            numeric(10)                    not null
      check (ASA327),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA328)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA329)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA330)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA331)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA332)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA333)),
   CODIGO_VNR           varchar(20)                    null,
   LARGO                numeric(10)                    null
      check (LARGO is null or (ASA334)),
   ANCHO                numeric(10)                    null
      check (ANCHO is null or (ASA335)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_BOVEDA unique (EMPRESA_ID, PERIODO_STAR, BOVEDA_ID),
   foreign key FK_BOVEDA_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_BOVEDA_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_BOVEDA_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_BOVEDA_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_TENSION                                          */
/*==============================================================*/
create table TIPO_TENSION (
   TIPO_TENSION_ID      numeric(2)                     not null
      check (ASA732),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_TENSION unique (TIPO_TENSION_ID) )
   ;

/*==============================================================*/
/* Table: CAMARA                                                */
/*==============================================================*/
create table CAMARA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA337),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA338),
   PERIODO_STAR_ID      integer                        not null
      check (ASA339),
   CAMARA_ID            numeric(10)                    not null
      check (ASA340),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA341)),
   TIPO_TENSION_ID      numeric(2)                     null
      check (TIPO_TENSION_ID is null or (ASA342)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA343)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA344)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA345)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA346)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA347)),
   CODIGO_VNR           varchar(20)                    null,
   APOYO_COMUNICACIONES numeric(3)                     null,
   APOYO_TV_CABLE       numeric(3)                     null,
   APOYO_ALUMBRADO      numeric(1)                     null,
   APOYO_OTROS          numeric(3)                     null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_CAMARA unique (EMPRESA_ID, PERIODO_STAR, CAMARA_ID),
   foreign key FK_CAMARA_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_CAMARA_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_CAMARA_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_CAMARA_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_CAMARA_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: CANALIZACION                                          */
/*==============================================================*/
create table CANALIZACION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA348),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA349),
   PERIODO_STAR_ID      integer                        not null
      check (ASA350),
   CANALIZACION_ID      numeric(10)                    not null
      check (ASA351),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA352)),
   TIPO_TENSION_ID      numeric(2)                     null
      check (TIPO_TENSION_ID is null or (ASA353)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA354)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA355)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA356)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA357)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_CANALIZACION unique (EMPRESA_ID, PERIODO_STAR, CANALIZACION_ID),
   foreign key FK_CANALIZA_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_CANALIZA_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_CANALIZA_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_CANALIZA_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: CGJ_INTERRUPCION_COMUNA                               */
/*==============================================================*/
create table CGJ_INTERRUPCION_COMUNA (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA362),
   INTERRUPCION_ID      varchar(18)                    not null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   CAUSA_ID             numeric(5)                     null,
   INCIDENCIA_ID        numeric(10)                    null,
   COMUNA_ID            numeric(7)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CGJ_INT_CHILQUINTA                                    */
/*==============================================================*/
create table CGJ_INT_CHILQUINTA (
   SIGLA                varchar(30)                    null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA363),
   DESC_CALIFICACION_INT varchar(60)                    null,
   DESC_CAUSA           varchar(100)                   null,
   COMUNA               varchar(60)                    null,
   REGION               varchar(60)                    null,
   CANTIDAD_PUNTOS_CONSUMO numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CMC_COORD_PCONSUMO                                    */
/*==============================================================*/
create table CMC_COORD_PCONSUMO (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA364),
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   NODO_IEC_ID          numeric(15)                    null,
   DATUM_ID             numeric(2)                     null,
   NOMBRE               varchar(60)                    null,
   ZONA_UTM             numeric(2)                     null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CMC_NODO                                              */
/*==============================================================*/
create table CMC_NODO (
   NODO_IEC_ID          numeric(15)                    null,
   EMPRESA_ID           numeric(3)                     null,
   ALIMENTADOR_ID       numeric(10)                    null,
   DATUM_ID             numeric(2)                     null,
   ZONA_UTM             numeric(2)                     null,
   TIPO_NODO_ID         numeric(2)                     null,
   TIPO_INSTALACION_ID  numeric(2)                     null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CMC_NODO_CABECERA                                     */
/*==============================================================*/
create table CMC_NODO_CABECERA (
   NODO_IEC_ID          numeric(15)                    null,
   EMPRESA_ID           numeric(3)                     null,
   ALIMENTADOR_ID       numeric(10)                    null,
   DATUM_ID             numeric(2)                     null,
   ZONA_UTM             numeric(2)                     null,
   TIPO_NODO_ID         numeric(2)                     null,
   TIPO_INSTALACION_ID  numeric(2)                     null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CMC_NODO_HOJA                                         */
/*==============================================================*/
create table CMC_NODO_HOJA (
   NODO_IEC_ID          numeric(15)                    null,
   EMPRESA_ID           numeric(3)                     null,
   ALIMENTADOR_ID       numeric(10)                    null,
   DATUM_ID             numeric(2)                     null,
   ZONA_UTM             numeric(2)                     null,
   TIPO_NODO_ID         numeric(2)                     null,
   TIPO_INSTALACION_ID  numeric(2)                     null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CMC_NODO_MONOHIJO                                     */
/*==============================================================*/
create table CMC_NODO_MONOHIJO (
   CORRELATIVO          numeric                        null,
   EMPRESA_ID           numeric(3)                     null,
   NODO_IEC_ID          numeric(15)                    null,
   CANTIDAD             numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CMC_NODO_MULTIHIJO                                    */
/*==============================================================*/
create table CMC_NODO_MULTIHIJO (
   CORRELATIVO          numeric                        null,
   EMPRESA_ID           numeric(3)                     null,
   NODO_IEC_ID          numeric(15)                    null,
   CANTIDAD             numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CMC_NODO_VERTICE                                      */
/*==============================================================*/
create table CMC_NODO_VERTICE (
   EMPRESA_ID           numeric(3)                     null,
   INSTALACION_ID       numeric(10)                    null,
   TIPO_INSTALACION_ID  numeric(2)                     null,
   NODO_VERTICE         NODO    null );

/*==============================================================*/
/* Table: COLMENA_250M_CHILE_LIMITE_COMU                        */
/*==============================================================*/
create table COLMENA_250M_CHILE_LIMITE_COMU (
   OBJECTID             numeric                        not null,
   CROW                 numeric                        null,
   CCOL                 numeric                        null,
   COMUNA_ID            numeric                        null,
   COMUNA_ID2           numeric                        null,
   SHAPE_LENGTH         float(4)                       null,
   SHAPE_AREA           float(4)                       null,
   GEOM                 char(10)                       null,
   tiene_errores        tinyint                        not null default 0,
   constraint COLMENA_250M_CHILE_LIMITE_C_PK unique (OBJECTID) )
   ;

/*==============================================================*/
/* Table: TIPO_CONEXION_NODO                                    */
/*==============================================================*/
create table TIPO_CONEXION_NODO (
   TIPO_CONEXION_NODO_ID numeric(2)                     not null
      check (ASA713),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_CONEXION_NODO unique (TIPO_CONEXION_NODO_ID) )
   ;

/*==============================================================*/
/* Table: CONEXION_NODO_IEC                                     */
/*==============================================================*/
create table CONEXION_NODO_IEC (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA367),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA368),
   PERIODO_STAR_ID      integer                        not null
      check (ASA369),
   NODO_IEC_ID_1        numeric(15)                    not null
      check (ASA370),
   NODO_IEC_ID_2        numeric(15)                    not null
      check (ASA371),
   TIPO_CONEXION_NODO_ID numeric(2)                     null
      check (TIPO_CONEXION_NODO_ID is null or (ASA372)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_CONEXION_NODO_IEC unique (EMPRESA_ID, PERIODO_STAR, NODO_IEC_ID_1, NODO_IEC_ID_2),
   foreign key FK_CONEXION_TIPO_CON (TIPO_CONEXION_NODO_ID)
         references TIPO_CONEXION_NODO (TIPO_CONEXION_NODO_ID)
         on update restrict,
   foreign key FK_NODO_IEC_CONEXION_NOD1 (EMPRESA_ID, NODO_IEC_ID_2, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_NODO_IEC_CONEXION_NOD2 (EMPRESA_ID, NODO_IEC_ID_1, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict )
   ;

/*==============================================================*/
/* Table: CONEXION_NODO_IEC_CMC                                 */
/*==============================================================*/
create table CONEXION_NODO_IEC_CMC (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA373),
   NODO_IEC_ID_1        numeric(15)                    not null,
   NODO_IEC_ID_2        numeric(15)                    not null,
   TIPO_CONEXION_NODO_ID numeric(2)                     null,
   CONEXION_TRAMO       numeric(1)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: CONEXION_NODO_INCIDENCIA                              */
/*==============================================================*/
create table CONEXION_NODO_INCIDENCIA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA374),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA375),
   PERIODO_STAR_ID      integer                        not null
      check (ASA376),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA377),
   NODO_INCIDENCIA_ID_1 numeric(15)                    not null
      check (ASA378),
   NODO_INCIDENCIA_ID_2 numeric(15)                    not null
      check (ASA379),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_CONEXION_NODO_INCIDENCIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, NODO_INCIDENCIA_ID_1, NODO_INCIDENCIA_ID_2),
   foreign key FK_NODO_INCIDENC_CONEXION_NOD2 (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID_1)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_CONEXION_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_NODO_INCIDENC_CONEXION_NOD1 (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID_2)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: CONS_CHILECTRA_PTO_TRAFO                              */
/*==============================================================*/
create table CONS_CHILECTRA_PTO_TRAFO (
   EMPRSA_ID            numeric(4)                     null,
   PUNTO_CONSUMO_ID     varchar(20)                    null,
   TRANSFORMADOR_ID     varchar(20)                    null,
   CONSUMO              numeric(20)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: DATOS_CHILECTRA_INVIERNO                              */
/*==============================================================*/
create table DATOS_CHILECTRA_INVIERNO (
   NRO                  numeric                        null,
   FECHA_INICIO         timestamp                      null,
   FECHA_TERMINO        timestamp                      null,
   CANTIDAD_INCIDENCIAS numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: DESCRIPCION_EVENTO                                    */
/*==============================================================*/
create table DESCRIPCION_EVENTO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA382),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA383),
   PERIODO_STAR_ID      integer                        not null
      check (ASA384),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA385),
   EVENTORED_ID         numeric(10)                    not null
      check (ASA386),
   DESCRIPCION_EVENTO_ID numeric(10)                    not null
      check (ASA387),
   TEXTO                varchar(200)                   null
      check (TEXTO is null or (ASA388)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_DESCRIPCION_EVENTO unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID, DESCRIPCION_EVENTO_ID),
   foreign key FK_DESCRIPC_EVENTO_R (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID)
         references EVENTO_RED (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EVENTORED_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: DETALLE_INT_CHILECTRA_INV                             */
/*==============================================================*/
create table DETALLE_INT_CHILECTRA_INV (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA389),
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   INCIDENCIA_ID        numeric(10)                    null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   CAUSA_ID             numeric(5)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: DM_INTERR_PTO_CONSUMO                                 */
/*==============================================================*/
create table DM_INTERR_PTO_CONSUMO (
   EMPRESA_ID           numeric(3)                     not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   COMUNA_ID            numeric(7)                     null,
   ALIMENTADOR_ID       numeric(10)                    null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA390),
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: EMPALME                                               */
/*==============================================================*/
create table EMPALME (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA391),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA392),
   PERIODO_STAR_ID      integer                        not null
      check (ASA393),
   EMPALME_ID           numeric(10)                    not null
      check (ASA394),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA395)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA396)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA397)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA398)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA399)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_EMPALME unique (EMPRESA_ID, PERIODO_STAR, EMPALME_ID),
   foreign key FK_EMPALME_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_EMPALME_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_EMPALME_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ENMALLE                                               */
/*==============================================================*/
create table ENMALLE (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA403),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA404),
   PERIODO_STAR_ID      integer                        not null
      check (ASA405),
   ENMALLE_ID           numeric(10)                    not null
      check (ASA406),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA407)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA408)),
   TIPO_TENSION_ID      numeric(2)                     null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA409)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA410)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA411)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA412)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ENMALLE unique (EMPRESA_ID, PERIODO_STAR, ENMALLE_ID),
   foreign key FK_ENMALLE_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_ENMALLE_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_ENMALLE_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_ENMALLE_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_ENMALLE_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_EQUIPO                                           */
/*==============================================================*/
create table TIPO_EQUIPO (
   TIPO_EQUIPO_ID       numeric(2)                     not null
      check (ASA720),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_EQUIPO unique (TIPO_EQUIPO_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_SERVICIO_EQUIPO                                  */
/*==============================================================*/
create table TIPO_SERVICIO_EQUIPO (
   TIPO_SERVICIO_EQUIPO_ID numeric(2)                     not null
      check (ASA730),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_SERVICIO_EQUIPO unique (TIPO_SERVICIO_EQUIPO_ID) )
   ;

/*==============================================================*/
/* Table: EQUIPO                                                */
/*==============================================================*/
create table EQUIPO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA413),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA414),
   PERIODO_STAR_ID      integer                        not null
      check (ASA415),
   EQUIPO_ID            numeric(10)                    not null
      check (ASA416),
   TIPO_EQUIPO_ID       numeric(2)                     null
      check (TIPO_EQUIPO_ID is null or (ASA417)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA418)),
   TIPO_SERVICIO_EQUIPO_ID numeric(2)                     null
      check (TIPO_SERVICIO_EQUIPO_ID is null or (ASA419)),
   TIPO_TENSION_ID      numeric(2)                     null
      check (TIPO_TENSION_ID is null or (ASA420)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA421)),
   NODO_ESQUEMATICO_ID  numeric(15)                    null
      check (NODO_ESQUEMATICO_ID is null or (ASA422)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA423)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA424)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA425)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA426)),
   CODIGO_VNR           varchar(20)                    null,
   ES_EQUIPO_SUBESTACION numeric(1)                     null
      check (ES_EQUIPO_SUBESTACION is null or (ASA427)),
   DENOMINACION         varchar(100)                   null
      check (DENOMINACION is null or (ASA428)),
   NORMALMENTE_CERRADO  numeric(1)                     null
      check (NORMALMENTE_CERRADO is null or (ASA429)),
   PEEM_ID              numeric(10)                    null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_EQUIPO unique (EMPRESA_ID, PERIODO_STAR, EQUIPO_ID),
   foreign key FK_EQUIPO_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_EQUIPO_TIPO_EQU (TIPO_EQUIPO_ID)
         references TIPO_EQUIPO (TIPO_EQUIPO_ID)
         on update restrict,
   foreign key FK_EQUIPO_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_EQUIPO_TIPO_SER (TIPO_SERVICIO_EQUIPO_ID)
         references TIPO_SERVICIO_EQUIPO (TIPO_SERVICIO_EQUIPO_ID)
         on update restrict,
   foreign key FK_EQUIPO_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_EQUIPO_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict,
   foreign key FK_EQUIPO_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict )
   ;

/*==============================================================*/
/* Table: EQUIPO_TOPOLOGIA                                      */
/*==============================================================*/
create table EQUIPO_TOPOLOGIA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA430),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA431),
   PERIODO_STAR_ID      integer                        not null
      check (ASA432),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA433),
   EQUIPO_ID            numeric(10)                    not null
      check (ASA434),
   NODO_INCIDENCIA_ID   numeric(15)                    null
      check (NODO_INCIDENCIA_ID is null or (ASA435)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA436)),
   TIPO_TENSION_ID      numeric(2)                     null
      check (TIPO_TENSION_ID is null or (ASA437)),
   TIPO_SERVICIO_EQUIPO_ID numeric(2)                     null
      check (TIPO_SERVICIO_EQUIPO_ID is null or (ASA438)),
   TIPO_EQUIPO_ID       numeric(2)                     null
      check (TIPO_EQUIPO_ID is null or (ASA439)),
   ACTIVO_INICIAL       numeric(1)                     null,
   ACTIVO_FINAL         numeric(1)                     null,
   CERRADO_INICIAL      numeric(1)                     null
      check (CERRADO_INICIAL is null or (ASA440)),
   CERRADO_FINAL        numeric(1)                     null
      check (CERRADO_FINAL is null or (ASA441)),
   DENOMINACION         varchar(100)                   null
      check (DENOMINACION is null or (ASA442)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_EQUIPO_TOPOLOGIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, EQUIPO_ID),
   foreign key FK_EQUIPO_T_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_EQUIPO_T_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_EQUIPO_T_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_EQUIPO_T_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_EQUIPO_T_TIPO_EQU (TIPO_EQUIPO_ID)
         references TIPO_EQUIPO (TIPO_EQUIPO_ID)
         on update restrict,
   foreign key FK_EQUIPO_T_TIPO_SER (TIPO_SERVICIO_EQUIPO_ID)
         references TIPO_SERVICIO_EQUIPO (TIPO_SERVICIO_EQUIPO_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ERRORES_CARGA                                         */
/*==============================================================*/
create table ERRORES_CARGA (
   EMPRESA_ID           numeric                        null
      check (EMPRESA_ID is null or (ASA443)),
   PERIODO_STAR         varchar(6)                     null
      check (PERIODO_STAR is null or (ASA444)),
   PERIODO_STAR_ID      integer                        not null
      check (ASA445),
   TABLA                varchar(30)                    null
      check (TABLA is null or (ASA446)),
   EXTRA_INFO           varchar(255)                   null,
   NRO_LINEA            numeric                        null
      check (NRO_LINEA is null or (ASA447)),
   DESCRIPCION_ERROR    varchar(255)                   null
      check (DESCRIPCION_ERROR is null or (ASA448)),
   ERROR_CODE           numeric(7)                     null
      check (ERROR_CODE is null or (ASA449)),
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: ERRORES_EV                                            */
/*==============================================================*/
create table ERRORES_EV (
   EMPRESA_ID           numeric                        null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA450),
   CANT                 numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: ERROR_FK                                              */
/*==============================================================*/
create table ERROR_FK (
   DESCRIPCION          varchar(255)                   null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: ESTRUCTURA_BT                                         */
/*==============================================================*/
create table ESTRUCTURA_BT (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA451),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA452),
   PERIODO_STAR_ID      integer                        not null
      check (ASA453),
   ESTRUCTURA_BT_ID     numeric(10)                    not null
      check (ASA454),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA455)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA456)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA457)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA458)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA459)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA460)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ESTRUCTURA_BT unique (EMPRESA_ID, PERIODO_STAR, ESTRUCTURA_BT_ID),
   foreign key FK_ESTRUCTU_NODO_IE3 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_ESTRUCTU_COMUN2 (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_ESTRUCTU_EMPRES1 (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_ESTRUCTU_TIPO_PR2 (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ESTRUCTURA_MT                                         */
/*==============================================================*/
create table ESTRUCTURA_MT (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA461),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA462),
   PERIODO_STAR_ID      integer                        not null
      check (ASA463),
   ESTRUCTURA_MT_ID     numeric(10)                    not null
      check (ASA464),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA465)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA466)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA467)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA468)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA469)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA470)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ESTRUCTURA_MT unique (EMPRESA_ID, PERIODO_STAR, ESTRUCTURA_MT_ID),
   foreign key FK_ESTRUCTU_NODO_IE1 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_ESTRUCTU_COMUN1 (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_ESTRUCTU_EMPRES3 (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_ESTRUCTU_TIPO_PR1 (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: ESTRUCTURA_SED                                        */
/*==============================================================*/
create table ESTRUCTURA_SED (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA471),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA472),
   PERIODO_STAR_ID      integer                        not null
      check (ASA473),
   ESTRUCTURA_SED_ID    numeric(10)                    not null
      check (ASA474),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA475)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA476)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA477)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA478)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA479)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA480)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric                        null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_ESTRUCTURA_SED unique (EMPRESA_ID, PERIODO_STAR, ESTRUCTURA_SED_ID),
   foreign key FK_ESTRUCTU_NODO_IE2 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_ESTRUCTU_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_ESTRUCTU_EMPRES2 (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_ESTRUCTU_TIPO_PR3 (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: FBG_RESUMEN_CARGA                                     */
/*==============================================================*/
create table FBG_RESUMEN_CARGA (
   EMPRESA_ID           numeric                        null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA490),
   TABLA                varchar(30)                    null,
   REGISTROS_TEXTO      numeric                        null,
   REGISTROS_CARGADOS   numeric                        null,
   REGISTROS_RECHAZADOS numeric                        null,
   FECHA_INICIO         timestamp                      null,
   FECHA_TERMINO        timestamp                      null,
   NOMBRE_ARCHIVO       varchar(255)                   null )
   ;

/*==============================================================*/
/* Table: TIPO_FUENTE_ENERGIA                                   */
/*==============================================================*/
create table TIPO_FUENTE_ENERGIA (
   TIPO_FUENTE_ENERGIA_ID numeric(2)                     not null
      check (ASA722),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_FUENTE_ENERGIA unique (TIPO_FUENTE_ENERGIA_ID) )
   ;

/*==============================================================*/
/* Table: FUENTE_ENERGIA_RED                                    */
/*==============================================================*/
create table FUENTE_ENERGIA_RED (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA491),
   FUENTE_ENERGIA_RED_ID numeric(10)                    not null,
   INCIDENCIA_ID        numeric(10)                    not null,
   TIPO_FUENTE_ENERGIA_ID numeric(2)                     null
      check (TIPO_FUENTE_ENERGIA_ID is null or (ASA492)),
   NODO_INCIDENCIA_ID   numeric(15)                    null
      check (NODO_INCIDENCIA_ID is null or (ASA493)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_FUENTE_ENERGIA_RED unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, FUENTE_ENERGIA_RED_ID),
   foreign key FK_FUENTE_E_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_FUENTE_E_TIPO_FUE (TIPO_FUENTE_ENERGIA_ID)
         references TIPO_FUENTE_ENERGIA (TIPO_FUENTE_ENERGIA_ID)
         on update restrict,
   foreign key FK_FUENTE_E_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: G_INTERRUPCION_PTO_CONSUMO                            */
/*==============================================================*/
create table G_INTERRUPCION_PTO_CONSUMO (
   EMPRESA_ID           numeric(3)                     null
      check (EMPRESA_ID is null or (ASA495)),
   PERIODO_STAR         varchar(6)                     null
      check (PERIODO_STAR is null or (ASA496)),
   PERIODO_STAR_ID      integer                        not null
      check (ASA497),
   INCIDENCIA_ID        numeric(10)                    null
      check (INCIDENCIA_ID is null or (ASA498)),
   INTERRUPCION_ID      varchar(18)                    null
      check (INTERRUPCION_ID is null or (ASA499)),
   TIEMPO_INTERRUMPIDO  numeric(10)                    null
      check (TIEMPO_INTERRUMPIDO is null or (ASA500)),
   DATUM_ID             numeric(2)                     null
      check (DATUM_ID is null or (ASA501)),
   TIPO_NODO_ID         numeric(2)                     null
      check (TIPO_NODO_ID is null or (ASA502)),
   X                    numeric(15,3)                  null
      check (X is null or (ASA503)),
   Y                    numeric(15,3)                  null
      check (Y is null or (ASA504)),
   ZONA_UTM             numeric(2)                     null
      check (ZONA_UTM is null or (ASA505)),
   FMIK                 numeric                        null,
   FMIT                 numeric                        null,
   TTIT                 numeric                        null,
   TTIK                 numeric                        null,
   CALIFICACION         varchar(100)                   null,
   CAUSA                varchar(100)                   null,
   UBICACION            char(10)                       null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: INCIDENCIA_NODOS_QUEUE                                */
/*==============================================================*/
create table INCIDENCIA_NODOS_QUEUE (
   EMPRESA_ID           numeric(3)                     not null,
   INCIDENCIA_ID        numeric(10)                    not null,
   NODO_PADRE_ID        numeric(15)                    null,
   NODO_INCIDENCIA_ID   numeric(15)                    not null,
   PROCESADO            numeric(1)                     null,
   EN_LOOP              numeric(1)                     null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA510),
   tiene_errores        tinyint                        not null default 0,
   constraint INCIDENCIA_NODOS_QUEUE_PK unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, NODO_INCIDENCIA_ID) )
   ;

/*==============================================================*/
/* Table: INCIDENCIA_PROCESADA                                  */
/*==============================================================*/
create table INCIDENCIA_PROCESADA (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(10)                    null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA511),
   INCIDENCIA_ID        numeric(10)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: INC_PCONSUMOS_CONECTADOS                              */
/*==============================================================*/
create table INC_PCONSUMOS_CONECTADOS (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA512),
   CONECTADOS           numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: INC_PUNTO_CONSUMO_CONECTADOS                          */
/*==============================================================*/
create table INC_PUNTO_CONSUMO_CONECTADOS (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA513),
   INCIDENCIA_ID        numeric(10)                    null,
   CONECTADOS           numeric                        null,
   INFORMADOS           numeric                        null,
   CARGADOS             numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: INF_PCONSUMOS_CONECTADOS                              */
/*==============================================================*/
create table INF_PCONSUMOS_CONECTADOS (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA514),
   CONECTADOS           numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: INTERRUPCION_AUDIT                                    */
/*==============================================================*/
create table INTERRUPCION_AUDIT (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA526),
   INTERRUPCION_ID      varchar(18)                    not null,
   CALIFICACION_INTERRUPCION_ID numeric(2)                     null,
   TIPO_ORIGEN_INTERRUPCION_ID numeric(2)                     null,
   SISTEMA_ELECTRICO_ID numeric(10)                    null,
   CAUSA_ID             numeric(5)                     null,
   INCIDENCIA_ID        numeric(10)                    null,
   EVENTORED_ID         numeric(10)                    null,
   EMPRESA_SUMINISTRADORA_ID numeric(3)                     null,
   INTERRUPCION_SUMINISTRADORA_ID varchar(18)                    null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: INTERRUPCION_PUNTO_CONSUMO                            */
/*==============================================================*/
create table INTERRUPCION_PUNTO_CONSUMO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA527),
   PERIODO_STAR         varchar(6)                     null
      check (PERIODO_STAR is null or (ASA528)),
   PERIODO_STAR_ID      integer                        not null
      check (ASA529),
   INCIDENCIA_ID        numeric(10)                    null
      check (INCIDENCIA_ID is null or (ASA530)),
   INTERRUPCION_ID      varchar(18)                    not null
      check (ASA531),
   BLOQUE_REPOSICION_ID numeric(10)                    not null
      check (ASA532),
   PUNTO_CONSUMO_ID     numeric(30)                    not null
      check (ASA533),
   TIEMPO_INTERRUMPIDO  numeric(10)                    null
      check (TIEMPO_INTERRUMPIDO is null or (ASA534)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_INTERRUPCION_PUNTO_CONSUMO unique (INTERRUPCION_ID, BLOQUE_REPOSICION_ID, EMPRESA_ID, PUNTO_CONSUMO_ID) )
   ;

/*==============================================================*/
/* Table: LVL_INTERRUPCION_VIIIREGION                           */
/*==============================================================*/
create table LVL_INTERRUPCION_VIIIREGION (
   EMPRESA_ID           numeric(3)                     not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   COMUNA_ID            numeric(7)                     null,
   NOMBRE_COMUNA        varchar(100)                   null,
   REGION_ID            numeric(6)                     null,
   NOMBRE_REGION        varchar(100)                   null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   TIPO_RURALIDAD       varchar(60)                    null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   DURACION             numeric(10)                    null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: MARCA                                                 */
/*==============================================================*/
create table MARCA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA535),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA536),
   PERIODO_STAR_ID      integer                        not null
      check (ASA537),
   MARCA_ID             numeric(10)                    not null
      check (ASA538),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA539)),
   TEXTO                varchar(250)                   null
      check (TEXTO is null or (ASA540)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_MARCA unique (EMPRESA_ID, PERIODO_STAR, MARCA_ID),
   foreign key FK_MARCA_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_MARCA_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: MATRIZ_TABLA                                          */
/*==============================================================*/
create table MATRIZ_TABLA (
   IDENTIFICADOR        numeric                        null,
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA541),
   NODO_ID              numeric(15)                    null,
   TIPO_CONEXION_NODO_ID numeric(2)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: MEDIDOR                                               */
/*==============================================================*/
create table MEDIDOR (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA542),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA543),
   PERIODO_STAR_ID      integer                        not null
      check (ASA544),
   MEDIDOR_ID           numeric(10)                    not null
      check (ASA545),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA546)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA547)),
   NODO_ESQUEMATICO_ID  numeric(15)                    null
      check (NODO_ESQUEMATICO_ID is null or (ASA548)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA549)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA550)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA551)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA552)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_MEDIDOR unique (EMPRESA_ID, PERIODO_STAR, MEDIDOR_ID),
   foreign key FK_MEDIDOR_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_MEDIDOR_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_MEDIDOR_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_MEDIDOR_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: MED_INTERRUPCIONES                                    */
/*==============================================================*/
create table MED_INTERRUPCIONES (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA553),
   INTERRUPCION_ID      varchar(18)                    null,
   BLOQUE_REPOSICION_ID numeric(10)                    null,
   CALIFICACION_INTERRUPCION_ID numeric(2)                     null,
   CAUSA_ID             numeric(5)                     null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   DURACION             numeric                        null,
   CANTIDAD             numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: MED_SAIDI                                             */
/*==============================================================*/
create table MED_SAIDI (
   FECHA                timestamp                      null,
   HORAS                numeric                        null,
   SAIDI                numeric                        null,
   LN                   numeric                        null,
   ALPHA                numeric                        null,
   BETA                 numeric                        null,
   MED                  numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: MODULO_I3                                             */
/*==============================================================*/
create table MODULO_I3 (
   MODULO               char(5)                        null,
   ARCHIVOS_REQUERIDOS  numeric                        null,
   OBLIGATORIOS         numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: MVW_COMUNA_PUNTO_CONSUMO                              */
/*==============================================================*/
create table MVW_COMUNA_PUNTO_CONSUMO (
   COMUNA_ID            numeric(7)                     null,
   CLIENTES             numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

comment on table MVW_COMUNA_PUNTO_CONSUMO is
'snapshot table for snapshot SEC_INTERRUPCIONES2013.MVW_COMUNA_PUNTO_CONSUMO';

/*==============================================================*/
/* Table: MVW_DM_BASE_SAIDI_PCONSUMO                            */
/*==============================================================*/
create table MVW_DM_BASE_SAIDI_PCONSUMO (
   EMPRESA_ID           numeric(3)                     not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   COMUNA_ID            numeric(7)                     null,
   ALIMENTADOR_ID       numeric(10)                    null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA554),
   FH_INICIO_INTERRUPCION timestamp                      null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   DURACION_HRS         numeric                        null,
   CAUSA                varchar(100)                   null,
   SUBCAUSA             varchar(100)                   null,
   CLASIFICACION_FINAL  varchar(60)                    null,
   COMUNA               varchar(60)                    null,
   ALIMENTADOR          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

comment on table MVW_DM_BASE_SAIDI_PCONSUMO is
'snapshot table for snapshot SEC_INTERRUPCIONES2013.MVW_DM_BASE_SAIDI_PCONSUMO';

/*==============================================================*/
/* Table: MVW_PUNTO_CONSUMO_HRS_INTERR                          */
/*==============================================================*/
create table MVW_PUNTO_CONSUMO_HRS_INTERR (
   EMPRESA_ID           numeric(3)                     not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   COMUNA_ID            numeric                        null,
   ANHO_MES             varchar(7)                     null,
   EXTERNAS             numeric                        null,
   INTERNAS             numeric                        null,
   FMAYOR               numeric                        null,
   CAUSA                varchar(100)                   null,
   SUBCAUSA             varchar(100)                   null,
   tiene_errores        tinyint                        not null default 0 )
   ;

comment on table MVW_PUNTO_CONSUMO_HRS_INTERR is
'snapshot table for snapshot SEC_INTERRUPCIONES2013.MVW_PUNTO_CONSUMO_HRS_INTERR';

/*==============================================================*/
/* Table: MVW_REGION_COMUNA_EMPRESA                             */
/*==============================================================*/
create table MVW_REGION_COMUNA_EMPRESA (
   EMPRESA_ID           numeric(3)                     not null,
   COMUNA_ID            numeric(6)                     null,
   NOMBRE_COMUNA        varchar(100)                   null,
   EMPRESA              varchar(30)                    null,
   CANTIDAD             numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

comment on table MVW_REGION_COMUNA_EMPRESA is
'snapshot table for snapshot SEC_INTERRUPCIONES2013.MVW_REGION_COMUNA_EMPRESA';

/*==============================================================*/
/* Table: NODO_CONECTADO                                        */
/*==============================================================*/
create table NODO_CONECTADO (
   NODO_IEC_ID          numeric(15)                    null,
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA555),
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: NODO_IEC_CABECERA                                     */
/*==============================================================*/
create table NODO_IEC_CABECERA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA567),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA568),
   PERIODO_STAR_ID      integer                        not null
      check (ASA569),
   NODO_IEC_ID          numeric(15)                    not null
      check (ASA570),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NODO_IEC_CABECERA unique (EMPRESA_ID, PERIODO_STAR, NODO_IEC_ID),
   foreign key FK_NODO_IEC_NODO_IE1 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict )
   ;

/*==============================================================*/
/* Table: NODO_IEC_CMC                                          */
/*==============================================================*/
create table NODO_IEC_CMC (
   NODO_IEC_SEC         numeric(20)                    null,
   NODO_IEC_ID          numeric(15)                    not null,
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA571),
   ALIMENTADOR_ID       numeric(10)                    null,
   DATUM_ID             numeric(2)                     not null,
   ZONA_UTM             numeric(2)                     not null,
   TIPO_NODO_ID         numeric(2)                     not null,
   TIPO_INSTALACION_ID  numeric(2)                     not null,
   X                    numeric(15,3)                  not null,
   Y                    numeric(15,3)                  not null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: NODO_IEC_CMC_PROCESADO                                */
/*==============================================================*/
create table NODO_IEC_CMC_PROCESADO (
   NODO_IEC_SEC         numeric(20)                    null,
   NODO_IEC_ID          numeric(15)                    not null,
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA572),
   ALIMENTADOR_ID       numeric(10)                    null,
   DATUM_ID             numeric(2)                     not null,
   ZONA_UTM             numeric(2)                     not null,
   TIPO_NODO_ID         numeric(2)                     not null,
   TIPO_INSTALACION_ID  numeric(2)                     not null,
   X                    numeric(15,3)                  not null,
   Y                    numeric(15,3)                  not null,
   PADRES               varchar(4000)                  null,
   HIJOS                varchar(4000)                  null,
   ES_CABECERA          numeric(1)                     null default 0,
   NIVEL                numeric(5)                     null default 0,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: NODO_IEC_CMC_PROCESADO2                               */
/*==============================================================*/
create table NODO_IEC_CMC_PROCESADO2 (
   NODO_IEC_SEC         numeric(20)                    null,
   NODO_IEC_ID          numeric(15)                    not null,
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA573),
   ALIMENTADOR_ID       numeric(10)                    not null,
   DATUM_ID             numeric(2)                     not null,
   ZONA_UTM             numeric(2)                     not null,
   TIPO_NODO_ID         numeric(2)                     not null,
   TIPO_INSTALACION_ID  numeric(2)                     not null,
   X                    numeric(15,3)                  not null,
   Y                    numeric(15,3)                  not null,
   ES_CABECERA          numeric(1)                     null default 0,
   NIVEL                numeric(10)                    null default 0,
   RAMA                 numeric(10)                    null default 0,
   NODO_PADRE           numeric(15)                    not null default 0,
   ARBOL                numeric(5)                     null,
   tiene_errores        tinyint                        not null default 0,
   constraint NODO_IEC_CMC_PROCESADO2_PK unique (EMPRESA_ID, ALIMENTADOR_ID, NODO_IEC_ID, NODO_PADRE) )
   ;

/*==============================================================*/
/* Table: NODO_IEC_CONECTADO_RWO                                */
/*==============================================================*/
create table NODO_IEC_CONECTADO_RWO (
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA574),
   EMPRESA_ID           numeric(3)                     not null,
   NODO_IEC_ID          numeric(15)                    not null,
   EN_LOOP              numeric                        null,
   ORIGEN_NODO_IEC_ID   numeric(15)                    null,
   NIVEL                numeric(10)                    null,
   ALIMENTADOR_ID       numeric                        null default 10,
   TIPO_INSTALACION_ID  numeric(2)                     null,
   INSTALACION_ID       numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint NODO_IEC_CONECTADO_RWO_PK unique (PERIODO_STAR, EMPRESA_ID, NODO_IEC_ID) )
   ;

/*==============================================================*/
/* Table: NODO_IEC_CONEXION                                     */
/*==============================================================*/
create table NODO_IEC_CONEXION (
   EMPRESA_ID           numeric(3)                     null
      check (EMPRESA_ID is null or (ASA575)),
   PERIODO_STAR         varchar(6)                     null
      check (PERIODO_STAR is null or (ASA576)),
   PERIODO_STAR_ID      integer                        not null
      check (ASA577),
   PREV_NODO_IEC_ID     numeric(15)                    null,
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA578)),
   CNX_TRAMO_BT         numeric(1)                     null,
   CNX_TRAMO_MT         numeric(1)                     null,
   FALLO_CNX_CORTA      numeric(1)                     null,
   CNX_EMPALME          numeric(1)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: NODO_IEC_DIRECTO                                      */
/*==============================================================*/
create table NODO_IEC_DIRECTO (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA579),
   NODO_IEC_ID          numeric(15)                    not null,
   DATUM_ID             numeric(2)                     null,
   TIPO_NODO_ID         numeric(2)                     null,
   TIPO_INSTALACION_ID  numeric(2)                     null,
   ALIMENTADOR_ID       numeric(10)                    null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   ZONA_UTM             numeric(2)                     null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: SENTIDO_ENERGIA                                       */
/*==============================================================*/
create table SENTIDO_ENERGIA (
   SENTIDO_ENERGIA_ID   numeric(10)                    not null
      check (ASA695),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_SENTIDO_ENERGIA unique (SENTIDO_ENERGIA_ID) )
   ;

/*==============================================================*/
/* Table: NODO_IEC_EXTERNO                                      */
/*==============================================================*/
create table NODO_IEC_EXTERNO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA580),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA581),
   PERIODO_STAR_ID      integer                        not null
      check (ASA582),
   NODO_IEC_ID          numeric(15)                    not null
      check (ASA583),
   EMPRESA_EXTERNA_ID   numeric(3)                     null
      check (EMPRESA_EXTERNA_ID is null or (ASA584)),
   NODO_EXTERNO_ID      numeric(10)                    null
      check (NODO_EXTERNO_ID is null or (ASA585)),
   SENTIDO_ENERGIA_ID   numeric(10)                    null
      check (SENTIDO_ENERGIA_ID is null or (ASA586)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NODO_IEC_EXTERNO unique (NODO_IEC_ID, PERIODO_STAR, EMPRESA_ID),
   foreign key FK_NODO_IEC_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_NODO_IEC_EMPRESA (EMPRESA_EXTERNA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_NODO_IEC_SENTIDO_ (SENTIDO_ENERGIA_ID)
         references SENTIDO_ENERGIA (SENTIDO_ENERGIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: NODO_INCIDENCIA_CABECERA                              */
/*==============================================================*/
create table NODO_INCIDENCIA_CABECERA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA599),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA600),
   PERIODO_STAR_ID      integer                        not null
      check (ASA601),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA602),
   NODO_INCIDENCIA_ID   numeric(15)                    not null
      check (ASA603),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NODO_INCIDENCIA_CABECERA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, NODO_INCIDENCIA_ID),
   foreign key FK_NODO_INC_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: NODO_INCIDENCIA_CONECTADO                             */
/*==============================================================*/
create table NODO_INCIDENCIA_CONECTADO (
   EMPRESA_ID           numeric(3)                     null,
   INCIDENCIA_ID        numeric(10)                    null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA604),
   NODO_INCIDENCIA_ID   numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: NODO_INCIDENCIA_EXTERNO                               */
/*==============================================================*/
create table NODO_INCIDENCIA_EXTERNO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA605),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA606),
   PERIODO_STAR_ID      integer                        not null
      check (ASA607),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA608),
   NODO_INCIDENCIA_ID   numeric(15)                    not null
      check (ASA609),
   EMPRESA_EXTERNA_ID   numeric(3)                     null
      check (EMPRESA_EXTERNA_ID is null or (ASA610)),
   NODO_INCIDENCIA_EXTERNO_ID numeric(10)                    null
      check (NODO_INCIDENCIA_EXTERNO_ID is null or (ASA611)),
   SENTIDO_ENERGIA_ID   numeric(10)                    null
      check (SENTIDO_ENERGIA_ID is null or (ASA612)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NODO_INCIDENCIA_EXTERNO unique (EMPRESA_ID, INCIDENCIA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID),
   foreign key FK_EMPRESA_NODO_INCIDEN1 (EMPRESA_EXTERNA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_NODO_INCIDENC_NODO_INCIDEN2 (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_SENTIDO_ENERG_NODO_INCIDEN1 (SENTIDO_ENERGIA_ID)
         references SENTIDO_ENERGIA (SENTIDO_ENERGIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_DISPOSICION                                      */
/*==============================================================*/
create table TIPO_DISPOSICION (
   TIPO_DISPOSICION_ID  numeric(2)                     not null
      check (ASA714),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_DISPOSICION unique (TIPO_DISPOSICION_ID) )
   ;

/*==============================================================*/
/* Table: SUBESTACION_DISTRIBUCION                              */
/*==============================================================*/
create table SUBESTACION_DISTRIBUCION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA698),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA699),
   PERIODO_STAR_ID      integer                        not null
      check (ASA700),
   SUBESTACION_DISTRIBUCION_ID numeric(10)                    not null
      check (ASA701),
   TIPO_DISPOSICION_ID  numeric(2)                     null
      check (TIPO_DISPOSICION_ID is null or (ASA702)),
   PLACA_IDENTIFICACION varchar(250)                   null
      check (PLACA_IDENTIFICACION is null or (ASA703)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_SUBESTACION_DISTRIBUCION unique (EMPRESA_ID, PERIODO_STAR, SUBESTACION_DISTRIBUCION_ID),
   foreign key FK_SUBESTAC_TIPO_DIS (TIPO_DISPOSICION_ID)
         references TIPO_DISPOSICION (TIPO_DISPOSICION_ID)
         on update restrict,
   foreign key FK_SUBESTAC_EMPRES1 (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: NODO_SUBESTACION                                      */
/*==============================================================*/
create table NODO_SUBESTACION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA613),
   NODO_IEC_ID          numeric(15)                    not null
      check (ASA614),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA615),
   PERIODO_STAR_ID      integer                        not null
      check (ASA616),
   SUBESTACION_DISTRIBUCION_ID numeric(10)                    null
      check (SUBESTACION_DISTRIBUCION_ID is null or (ASA617)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NODO_SUBESTACION unique (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR),
   foreign key FK_NODO_SUB_SUBESTAC (EMPRESA_ID, PERIODO_STAR, SUBESTACION_DISTRIBUCION_ID)
         references SUBESTACION_DISTRIBUCION (EMPRESA_ID, PERIODO_STAR, SUBESTACION_DISTRIBUCION_ID)
         on update restrict,
   foreign key FK_NODO_SUB_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict )
   ;

/*==============================================================*/
/* Table: NUMERO_FASES                                          */
/*==============================================================*/
create table NUMERO_FASES (
   NUMERO_FASES         numeric(1)                     not null
      check (ASA618),
   tiene_errores        tinyint                        not null default 0,
   constraint PK_NUMERO_FASES unique (NUMERO_FASES) )
   ;

/*==============================================================*/
/* Table: PCT_NOT_EXISTS                                        */
/*==============================================================*/
create table PCT_NOT_EXISTS (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA619),
   INCIDENCIA_ID        numeric(10)                    null,
   PUNTO_CONSUMO_ID     numeric(30)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PERIODO_INFORMACION                                   */
/*==============================================================*/
create table PERIODO_INFORMACION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA620),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA621),
   PERIODO_STAR_ID      integer                        not null
      check (ASA622),
   MES_INFORMA          varchar(6)                     null
      check (MES_INFORMA is null or (ASA623)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PERIODO_INFORMACION unique (EMPRESA_ID, PERIODO_STAR),
   foreign key FK_PERIODO__EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: POSTE                                                 */
/*==============================================================*/
create table POSTE (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA624),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA625),
   PERIODO_STAR_ID      integer                        not null
      check (ASA626),
   POSTE_ID             numeric(10)                    not null
      check (ASA627),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA628)),
   TIPO_TENSION_ID      numeric(2)                     null
      check (TIPO_TENSION_ID is null or (ASA629)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA630)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA631)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA632)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA633)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA634)),
   CODIGO_VNR           varchar(20)                    null,
   APOYO_COMUNICACIONES numeric(3)                     null,
   APOYO_TV_CABLE       numeric(3)                     null,
   APOYO_ALUMBRADO      numeric(1)                     null,
   APOYO_OTROS          numeric(3)                     null,
   PEEM_ID              numeric(10)                    null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_POSTE unique (EMPRESA_ID, PERIODO_STAR, POSTE_ID),
   foreign key FK_POSTE_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_POSTE_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_POSTE_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_POSTE_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_POSTE_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: PROD_INT_CAUSA_2015                                   */
/*==============================================================*/
create table PROD_INT_CAUSA_2015 (
   FECHA_PERIODO        timestamp                      null,
   EMPRESA_ID           numeric(3)                     not null,
   SIGLA                varchar(30)                    null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA635),
   INTERRUPCION_ID      varchar(18)                    not null,
   CALIFICACION_INTERRUPCION_ID numeric(2)                     null,
   DESC_CLASIFICACION   varchar(100)                   null,
   DESC_CALIFICACION_INT varchar(60)                    null,
   CAUSA_ID             numeric(5)                     null,
   DESC_CAUSA           varchar(100)                   null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   COMUNA_ID            numeric(7)                     null,
   COMUNA               varchar(60)                    null,
   PROVINCIA            varchar(60)                    null,
   REGION               varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PTO_CONS_TOPO                                         */
/*==============================================================*/
create table PTO_CONS_TOPO (
   EMPRESA_ID           numeric(3)                     not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   TENSION              varchar(60)                    null,
   RURALIDAD            varchar(60)                    null,
   EMPALME              varchar(60)                    null,
   TRANSFORMADOR_ID     numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PUENTE                                                */
/*==============================================================*/
create table PUENTE (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA636),
   INCIDENCIA_ID        numeric(10)                    not null,
   PUENTE_ID            numeric(10)                    not null,
   NODO_INCIDENCIA_ID   numeric(15)                    null
      check (NODO_INCIDENCIA_ID is null or (ASA637)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA638)),
   ACTIVO_INICIAL       numeric(1)                     null,
   ACTIVO_FINAL         numeric(1)                     null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   foreign key FK_PUENTE_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_PUENTE_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_PUENTE_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_EMPALME                                          */
/*==============================================================*/
create table TIPO_EMPALME (
   TIPO_EMPALME_ID      numeric(2)                     not null
      check (ASA718),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_EMPALME unique (TIPO_EMPALME_ID) )
   ;

/*==============================================================*/
/* Table: PUNTO_SUMINISTRO                                      */
/*==============================================================*/
create table PUNTO_SUMINISTRO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA673),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA674),
   PERIODO_STAR_ID      integer                        not null
      check (ASA675),
   PUNTO_SUMINISTRO_ID  varchar(30)                    not null
      check (ASA676),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PUNTO_SUMINISTRO unique (EMPRESA_ID, PERIODO_STAR, PUNTO_SUMINISTRO_ID),
   foreign key FK_PUNTO_SU_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: SUBESTACION_PRIMARIA_DISTRIBUC                        */
/*==============================================================*/
create table SUBESTACION_PRIMARIA_DISTRIBUC (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA705),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA706),
   PERIODO_STAR_ID      integer                        not null
      check (ASA707),
   SUBESTACION_PRIMARIA_ID numeric(10)                    not null
      check (ASA708),
   NODO_IEC_ID          numeric(15)                    null,
   NOMBRE               varchar(100)                   null
      check (NOMBRE is null or (ASA709)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_SUBESTACION_PRIMARIA_DISTRI unique (EMPRESA_ID, PERIODO_STAR, SUBESTACION_PRIMARIA_ID),
   foreign key FK_SUBESTAC_EMPRES2 (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TIPO_RURALIDAD                                        */
/*==============================================================*/
create table TIPO_RURALIDAD (
   TIPO_RURALIDAD_ID    numeric(2)                     not null
      check (ASA729),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_RURALIDAD unique (TIPO_RURALIDAD_ID) )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO                                         */
/*==============================================================*/
create table PUNTO_CONSUMO (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA639),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA640),
   PERIODO_STAR_ID      integer                        not null
      check (ASA641),
   PUNTO_CONSUMO_ID     numeric(30)                    not null
      check (ASA642),
   PUNTO_SUMINISTRO_ID  varchar(30)                    null
      check (PUNTO_SUMINISTRO_ID is null or (ASA643)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA644)),
   TIPO_EMPALME_ID      numeric(2)                     null
      check (TIPO_EMPALME_ID is null or (ASA645)),
   SUBESTACION_PRIMARIA_ID numeric(10)                    null
      check (SUBESTACION_PRIMARIA_ID is null or (ASA646)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA647)),
   NODO_ESQUEMATICO_ID  numeric(15)                    null
      check (NODO_ESQUEMATICO_ID is null or (ASA648)),
   NUMERO_FASES         numeric(1)                     null
      check (NUMERO_FASES is null or (ASA649)),
   TIPO_RURALIDAD_ID    numeric(2)                     null
      check (TIPO_RURALIDAD_ID is null or (ASA650)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PUNTO_CONSUMO unique (EMPRESA_ID, PERIODO_STAR, PUNTO_CONSUMO_ID),
   foreign key FK_PUNTO_CO_TIPO_EMP (TIPO_EMPALME_ID)
         references TIPO_EMPALME (TIPO_EMPALME_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_PUNTO_SU (EMPRESA_ID, PERIODO_STAR, PUNTO_SUMINISTRO_ID)
         references PUNTO_SUMINISTRO (EMPRESA_ID, PERIODO_STAR, PUNTO_SUMINISTRO_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_SUBESTAC (EMPRESA_ID, PERIODO_STAR, SUBESTACION_PRIMARIA_ID)
         references SUBESTACION_PRIMARIA_DISTRIBUC (EMPRESA_ID, PERIODO_STAR, SUBESTACION_PRIMARIA_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_TIPO_RUR (TIPO_RURALIDAD_ID)
         references TIPO_RURALIDAD (TIPO_RURALIDAD_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_PUNTO_CO_RELATIONS_NUM_F (NUMERO_FASES)
         references NUMERO_FASES (NUMERO_FASES)
         on update restrict )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO012013026                                */
/*==============================================================*/
create table PUNTO_CONSUMO012013026 (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA651),
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   PUNTO_SUMINISTRO_ID  varchar(30)                    null,
   NODO_IEC_ID          numeric(15)                    null,
   TIPO_EMPALME_ID      numeric(2)                     null,
   SUBESTACION_PRIMARIA_ID numeric(10)                    null,
   COMUNA_ID            numeric(7)                     null,
   NODO_ESQUEMATICO_ID  numeric(15)                    null,
   NUMERO_FASES         numeric(1)                     null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO_8_9                                     */
/*==============================================================*/
create table PUNTO_CONSUMO_8_9 (
   REGION_ID            numeric(6)                     null,
   EMPRESA_ID           numeric(3)                     not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   COMUNA_ID            numeric(7)                     null,
   ZONA_UTM             numeric(2)                     null,
   DATUM_ID             numeric(2)                     null,
   X                    numeric                        null,
   Y                    numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO_DIRECTO                                 */
/*==============================================================*/
create table PUNTO_CONSUMO_DIRECTO (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA652),
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   PUNTO_SUMINISTRO_ID  varchar(30)                    null,
   NODO_IEC_ID          numeric(15)                    null,
   TIPO_EMPALME_ID      numeric(2)                     null,
   SUBESTACION_PRIMARIA_ID numeric(10)                    null,
   COMUNA_ID            numeric(7)                     null,
   NODO_ESQUEMATICO_ID  numeric(15)                    null,
   NUMERO_FASES         numeric(1)                     null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO_HORAS_INT_22                            */
/*==============================================================*/
create table PUNTO_CONSUMO_HORAS_INT_22 (
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   EXTERNAS             numeric                        null,
   INTERNAS             numeric                        null,
   FMAYOR               numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: SUBESTACION_INCIDENCIA                                */
/*==============================================================*/
create table SUBESTACION_INCIDENCIA (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA704),
   INCIDENCIA_ID        numeric(10)                    not null,
   SUBESTACION_INCIDENCIA_ID numeric(10)                    not null,
   PLACA_IDENTIFICACION varchar(100)                   null,
   CALLE                varchar(60)                    null,
   NUMERO               varchar(60)                    null,
   POBLACION            varchar(150)                   null,
   CIUDAD               varchar(60)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_SUBESTACION_INCIDENCIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, SUBESTACION_INCIDENCIA_ID),
   foreign key FK_SUBESTAC_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TRANSFORMADOR_TOPOLOGIA                               */
/*==============================================================*/
create table TRANSFORMADOR_TOPOLOGIA (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA794),
   INCIDENCIA_ID        numeric(10)                    not null,
   TRANSFORMADOR_ID     numeric(10)                    not null,
   NODO_INCIDENCIA_ID   numeric(15)                    null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   SUBESTACION_INCIDENCIA_ID numeric(10)                    null,
   COMUNA_ID            numeric(7)                     null,
   ACTIVO_INICIAL       numeric(1)                     null,
   ACTIVO_FINAL         numeric(1)                     null,
   ENERGIZADO_INICIAL   numeric(1)                     null,
   ENERGIZADO_FINAL     numeric(1)                     null,
   KVA_NOMINAL          numeric(8,2)                   null,
   FECHA_INSTALACION    timestamp                      null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TRANSFORMADOR_TOPOLOGIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, TRANSFORMADOR_ID),
   foreign key FK_TRANSFOR_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_TRANSFOR_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_COMUNA_TRANSFORMADO1 (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_TRANSFOR_SUBESTAC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, SUBESTACION_INCIDENCIA_ID)
         references SUBESTACION_INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, SUBESTACION_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_TIPO_RURALIDA_TRANSFORMADO1 (TIPO_RURALIDAD_ID)
         references TIPO_RURALIDAD (TIPO_RURALIDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: PUNTO_SUMINISTRO_INCIDENCIA                           */
/*==============================================================*/
create table PUNTO_SUMINISTRO_INCIDENCIA (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA677),
   INCIDENCIA_ID        numeric(10)                    not null,
   PUNTO_SUMINISTRO_ID  varchar(30)                    not null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PUNTO_SUMINISTRO_INCIDENCIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, PUNTO_SUMINISTRO_ID),
   foreign key FK_PUNTO_SU_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO_TOPOLOGIA                               */
/*==============================================================*/
create table PUNTO_CONSUMO_TOPOLOGIA (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA653),
   INCIDENCIA_ID        numeric(10)                    not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   TIPO_TENSION_ID      numeric(2)                     null,
   TRANSFORMADOR_ID     numeric(10)                    null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   NODO_INCIDENCIA_ID   numeric(15)                    null,
   TIPO_EMPALME_ID      numeric(2)                     null,
   PUNTO_SUMINISTRO_ID  varchar(30)                    null,
   COMUNA_ID            numeric(7)                     null,
   ACTIVO_INICIAL       numeric(1)                     null,
   ACTIVO_FINAL         numeric(1)                     null,
   ENERGIZADO_INICIAL   numeric(1)                     null,
   ENERGIZADO_FINAL     numeric(1)                     null,
   NUMERO_FASES         numeric(1)                     null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PUNTO_CONSUMO_TOPOLOGIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, PUNTO_CONSUMO_ID),
   foreign key FK_PUNTO_CO_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_TIPO_EMPALME_PUNTO_CONSUM1 (TIPO_EMPALME_ID)
         references TIPO_EMPALME (TIPO_EMPALME_ID)
         on update restrict,
   foreign key FK_COMUNA_PUNTO_CONSUM1 (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_TRANSFORMADOR_PUNTO_COSUMO1 (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, TRANSFORMADOR_ID)
         references TRANSFORMADOR_TOPOLOGIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, TRANSFORMADOR_ID)
         on update restrict,
   foreign key FK_PUNTO_SUMINIS_PUNTO_CONSUM1 (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, PUNTO_SUMINISTRO_ID)
         references PUNTO_SUMINISTRO_INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, PUNTO_SUMINISTRO_ID)
         on update restrict,
   foreign key FK_TIPO_RURALIDA_PUNTO_CONSUM1 (TIPO_RURALIDAD_ID)
         references TIPO_RURALIDAD (TIPO_RURALIDAD_ID)
         on update restrict,
   foreign key FK_PUNTO_CO_RELATIONS_NUMERO_F (NUMERO_FASES)
         references NUMERO_FASES (NUMERO_FASES)
         on update restrict )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO_TOPOLOGIA_TXT3                          */
/*==============================================================*/
create table PUNTO_CONSUMO_TOPOLOGIA_TXT3 (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA654),
   INCIDENCIA_ID        numeric(10)                    null,
   PUNTO_CONSUMO_ID     numeric(30)                    null,
   TIPO_TENSION_ID      numeric(2)                     null,
   TRANSFORMADOR_ID     numeric(10)                    null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   NODO_INCIDENCIA_ID   numeric(15)                    null,
   TIPO_EMPALME_ID      numeric(2)                     null,
   PUNTO_SUMINISTRO_ID  varchar(30)                    null,
   COMUNA_ID            numeric(7)                     null,
   ACTIVO_INICIAL       numeric(1)                     null,
   ACTIVO_FINAL         numeric(1)                     null,
   ENERGIZADO_INICIAL   numeric(1)                     null,
   ENERGIZADO_FINAL     numeric(1)                     null,
   NUMERO_FASES         numeric(1)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PUNTO_CONSUMO_TXT                                     */
/*==============================================================*/
create table PUNTO_CONSUMO_TXT (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA655),
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   PUNTO_SUMINISTRO_ID  varchar(30)                    null,
   NODO_IEC_ID          numeric(15)                    null,
   TIPO_EMPALME_ID      numeric(2)                     null,
   SUBESTACION_PRIMARIA_ID numeric(10)                    null,
   COMUNA_ID            numeric(7)                     null,
   NODO_ESQUEMATICO_ID  numeric(15)                    null,
   NUMERO_FASES         numeric(1)                     null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: PUNTO_DERIVACION                                      */
/*==============================================================*/
create table PUNTO_DERIVACION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA656),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA657),
   PERIODO_STAR_ID      integer                        not null
      check (ASA658),
   PUNTO_DERIVACION_ID  numeric(10)                    not null
      check (ASA659),
   NODO_ESQUEMATICO_ID  numeric(15)                    null
      check (NODO_ESQUEMATICO_ID is null or (ASA660)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PUNTO_DERIVACION unique (EMPRESA_ID, PERIODO_STAR, PUNTO_DERIVACION_ID),
   foreign key FK_PUNTO_DE_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: PUNTO_DERIVACION_INCIDENCIA                           */
/*==============================================================*/
create table PUNTO_DERIVACION_INCIDENCIA (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA661),
   INCIDENCIA_ID        numeric(10)                    not null,
   PUNTO_DERIVACION_INCIDENCIA_ID numeric(10)                    not null,
   NODO_INCIDENCIA_ID   numeric(15)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PUNTO_DERIVACION_INCIDENCIA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, PUNTO_DERIVACION_INCIDENCIA_ID),
   foreign key FK_PUNTO_DE_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_PUNTO_DE_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: PUNTO_FALLA                                           */
/*==============================================================*/
create table PUNTO_FALLA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA662),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA663),
   PERIODO_STAR_ID      integer                        not null
      check (ASA664),
   INCIDENCIA_ID        numeric(10)                    not null
      check (ASA665),
   PUNTO_FALLA_ID       numeric(10)                    not null
      check (ASA666),
   NODO_INCIDENCIA_ID   numeric(15)                    null
      check (NODO_INCIDENCIA_ID is null or (ASA667)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA668)),
   CALLE                varchar(60)                    null
      check (CALLE is null or (ASA669)),
   NUMERO               varchar(60)                    null
      check (NUMERO is null or (ASA670)),
   POBLACION            varchar(150)                   null
      check (POBLACION is null or (ASA671)),
   CIUDAD               varchar(60)                    null
      check (CIUDAD is null or (ASA672)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_PUNTO_FALLA unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, PUNTO_FALLA_ID),
   foreign key FK_PUNTO_FA_INCIDENC (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         references INCIDENCIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID)
         on update restrict,
   foreign key FK_PUNTO_FA_NODO_INC (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         references NODO_INCIDENCIA (INCIDENCIA_ID, EMPRESA_ID, PERIODO_STAR, NODO_INCIDENCIA_ID)
         on update restrict,
   foreign key FK_PUNTO_FA_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: P_BAJADA_RED                                          */
/*==============================================================*/
create table P_BAJADA_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA678),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_BOVEDA_RED                                          */
/*==============================================================*/
create table P_BOVEDA_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA679),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   NATURALEZA           char(2)                        null,
   SUBITEM              numeric                        null,
   ITEM                 numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_CAMARA_RED                                          */
/*==============================================================*/
create table P_CAMARA_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA680),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_TENSION_ID      numeric(2)                     null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric                        null,
   NATURALEZA           varchar(2)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_CANALIZACION_RED                                    */
/*==============================================================*/
create table P_CANALIZACION_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA681),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_TENSION_ID      numeric(2)                     null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric                        null,
   NATURALEZA           varchar(2)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_EMPALME_RED                                         */
/*==============================================================*/
create table P_EMPALME_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA682),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_TENSION_ID      numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   ITEM                 numeric                        null,
   NATURALEZA           char(2)                        null,
   SUBITEM              numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_EQUIPO_RED                                          */
/*==============================================================*/
create table P_EQUIPO_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA683),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   ES_EQUIPO_SUBESTACION numeric(1)                     null,
   TIPO_TENSION_ID      numeric(2)                     null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_EQUIPO_SED_RED                                      */
/*==============================================================*/
create table P_EQUIPO_SED_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA684),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   ES_EQUIPO_SUBESTACION numeric(1)                     null,
   TIPO_TENSION_ID      numeric(2)                     null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_ESTRUCTURA_BT_RED                                   */
/*==============================================================*/
create table P_ESTRUCTURA_BT_RED (
   EMPRESA_ID           numeric(3)                     null,
   ID                   numeric(10)                    null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA685),
   NODO_IEC_ID          numeric(15)                    null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric                        null,
   NATURALEZA           char(2)                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_ESTRUCTURA_MT_RED                                   */
/*==============================================================*/
create table P_ESTRUCTURA_MT_RED (
   EMPRESA_ID           numeric(3)                     null,
   ID                   numeric(10)                    null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA686),
   NODO_IEC_ID          numeric(15)                    null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric                        null,
   NATURALEZA           char(2)                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_ESTRUCTURA_SED_RED                                  */
/*==============================================================*/
create table P_ESTRUCTURA_SED_RED (
   EMPRESA_ID           numeric(3)                     null,
   ID                   numeric(10)                    null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA687),
   NODO_IEC_ID          numeric(15)                    null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric                        null,
   NATURALEZA           char(2)                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_MEDIDOR_RED                                         */
/*==============================================================*/
create table P_MEDIDOR_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA688),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   TIPO_TENSION_ID      numeric                        null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_POSTE_RED                                           */
/*==============================================================*/
create table P_POSTE_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA689),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   TIPO_TENSION_ID      numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric                        null,
   NATURALEZA           varchar(2)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_TOMA_TIERRA_RED                                     */
/*==============================================================*/
create table P_TOMA_TIERRA_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA690),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   TIPO_TENSION_ID      numeric(2)                     null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_TRAMO_BT_RED                                        */
/*==============================================================*/
create table P_TRAMO_BT_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA691),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric(2)                     null,
   NATURALEZA           char(2)                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_TRAMO_MT_RED                                        */
/*==============================================================*/
create table P_TRAMO_MT_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA692),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   SUBITEM              numeric                        null,
   ITEM                 numeric(2)                     null,
   NATURALEZA           char(2)                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: P_TRANSFORMADOR_RED                                   */
/*==============================================================*/
create table P_TRANSFORMADOR_RED (
   EMPRESA_ID           numeric(3)                     not null,
   ID                   numeric(10)                    not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA693),
   NODO_IEC_ID          numeric(15)                    not null,
   X                    numeric(15,3)                  null,
   Y                    numeric(15,3)                  null,
   IDENTIFICADOR_VNR    varchar(30)                    null,
   CONECTADO            numeric                        null,
   TIPO_PROPIEDAD_ID    numeric(2)                     null,
   CODIGO_VNR           varchar(20)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: QLK_INC_PTO_CONSUMO_COMUNA                            */
/*==============================================================*/
create table QLK_INC_PTO_CONSUMO_COMUNA (
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA694),
   INCIDENCIA_ID        numeric(10)                    null,
   INTERRUPCION_ID      varchar(18)                    null,
   BLOQUE_REPOSICION_ID numeric(10)                    null,
   COMUNA_ID            numeric                        null,
   CANTIDAD             numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: REGION_COMUNA_PROVINCIA                               */
/*==============================================================*/
create table REGION_COMUNA_PROVINCIA (
   REGION_ID            numeric(6)                     null,
   NOMBRE_REGION        varchar(100)                   null,
   COMUNA_ID            numeric(6)                     null,
   NOMBRE_COMUNA        varchar(100)                   null,
   PROVINCIA_ID         numeric(6)                     null,
   NOMBRE_PROVINCIA     varchar(100)                   null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: ROW_COUNT                                             */
/*==============================================================*/
create table ROW_COUNT (
   NROWS                numeric                        null )
   ;

/*==============================================================*/
/* Table: SISTEMA_COORDENADAS                                   */
/*==============================================================*/
create table SISTEMA_COORDENADAS (
   ID                   numeric(3)                     null,
   NOMBRE               varchar(60)                    null,
   DATUM_ID             numeric(2)                     null,
   ZONA_UTM             numeric(2)                     null,
   SDO_SRID             numeric                        null,
   DEFAULT_PROJECTION   numeric(1)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TBL_INT_RESUMEN                                       */
/*==============================================================*/
create table TBL_INT_RESUMEN (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA710),
   TIPO_RURALIDAD_ID    numeric(2)                     not null,
   TIPO_RURALIDAD       varchar(60)                    null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   NOMBRE_ALIMENTADOR   varchar(60)                    null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   CANTIDAD_TRAFOS      numeric                        null,
   KVA_AFECTADOS        numeric                        null,
   CLIENTES_AFECTADOS   numeric                        null,
   BLOQUE_VARIOS_ALIM   numeric                        null,
   CAUSA                varchar(100)                   null,
   SUBCAUSA             varchar(100)                   null,
   CALIFICACION         varchar(60)                    null,
   MES_ANHO             varchar(8)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TEMP_1_110128_1                                       */
/*==============================================================*/
create table TEMP_1_110128_1 (
   IDENTIFICADOR        numeric                        null,
   EMPRESA_ID           numeric(3)                     null,
   PERIODO_STAR         varchar(6)                     null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA711),
   NODO_ID              numeric(15)                    null,
   TIPO_CONEXION_NODO_ID numeric(2)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TEMP_HIJOS_ACTUALES                                   */
/*==============================================================*/
create table TEMP_HIJOS_ACTUALES (
   IDENTIFICADOR        numeric                        null,
   EMPRESA_ID           numeric(3)                     null,
   NODO_PADRE_ID        numeric(15)                    null,
   NODO_HIJO_ID         numeric(15)                    null,
   TIPO_CONEXION_NODO_ID numeric(2)                     null,
   NIVEL                numeric(10)                    null,
   ALIMENTADOR_ID       numeric(10)                    null,
   ARBOL_ID             numeric(5)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TEMP_NUEVOS_HIJOS                                     */
/*==============================================================*/
create table TEMP_NUEVOS_HIJOS (
   IDENTIFICADOR        numeric                        null,
   EMPRESA_ID           numeric(3)                     not null,
   NODO_PADRE_ID        numeric(15)                    not null,
   NODO_HIJO_ID         numeric(15)                    not null,
   TIPO_CONEXION_NODO_ID numeric(2)                     null,
   NIVEL                numeric(10)                    null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   ARBOL_ID             numeric(5)                     null,
   tiene_errores        tinyint                        not null default 0,
   constraint TEMP_NUEVOS_HIJOS_PK unique (EMPRESA_ID, ALIMENTADOR_ID, NODO_HIJO_ID, NODO_PADRE_ID) )
   ;

/*==============================================================*/
/* Table: TEMP_PADRES_ACTUALES                                  */
/*==============================================================*/
create table TEMP_PADRES_ACTUALES (
   IDENTIFICADOR        numeric                        null,
   EMPRESA_ID           numeric(3)                     null,
   NODO_PADRE_ID        numeric(15)                    null,
   NODO_HIJO_ID         numeric(15)                    null,
   TIPO_CONEXION_NODO_ID numeric(2)                     null,
   NIVEL                numeric(10)                    null,
   ALIMENTADOR_ID       numeric(10)                    null,
   ARBOL_ID             numeric(5)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TEMP_PADRES_PROCESADOS                                */
/*==============================================================*/
create table TEMP_PADRES_PROCESADOS (
   IDENTIFICADOR        numeric                        null,
   EMPRESA_ID           numeric(3)                     null,
   NODO_PADRE_ID        numeric(15)                    null,
   NODO_HIJO_ID         numeric(15)                    null,
   TIPO_CONEXION_NODO_ID numeric(2)                     null,
   NIVEL                numeric(10)                    null,
   ALIMENTADOR_ID       numeric(10)                    null,
   ARBOL_ID             numeric(5)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TIEMPO_INT_PTO_CONSUMO                                */
/*==============================================================*/
create table TIEMPO_INT_PTO_CONSUMO (
   EMPRESA_ID           numeric(3)                     not null,
   PUNTO_CONSUMO_ID     numeric(30)                    not null,
   COMUNA_ID            numeric(7)                     null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   TIEMPO_TOTAL_INT_HORAS numeric                        null,
   CANTIDAD_INTERRUPCIONES numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: TIPO_DISPOSICION_TRAMO                                */
/*==============================================================*/
create table TIPO_DISPOSICION_TRAMO (
   TIPO_DISPOSICION_TRAMO_ID numeric(2)                     not null
      check (ASA715),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_DISPOSICION_TRAMO unique (TIPO_DISPOSICION_TRAMO_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_EMPRESA                                          */
/*==============================================================*/
create table TIPO_EMPRESA (
   TIPO_EMPRESA_ID      numeric(3)                     not null
      check (ASA719),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint SYS_C00284287 unique (TIPO_EMPRESA_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_INSTALACION_ESQUEMATICO                          */
/*==============================================================*/
create table TIPO_INSTALACION_ESQUEMATICO (
   TIPO_INSTALACION_ESQ_ID numeric(2)                     not null
      check (ASA724),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_INSTALACION_ESQUEMATIC unique (TIPO_INSTALACION_ESQ_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_TECNOLOGIA                                       */
/*==============================================================*/
create table TIPO_TECNOLOGIA (
   TIPO_TECNOLOGIA_ID   numeric(2)                     not null
      check (ASA731),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_TECNOLOGIA unique (TIPO_TECNOLOGIA_ID) )
   ;

/*==============================================================*/
/* Table: TIPO_TOMA_TIERRA                                      */
/*==============================================================*/
create table TIPO_TOMA_TIERRA (
   TIPO_TOMA_TIERRA_ID  numeric(2)                     not null
      check (ASA733),
   DESCRIPCION          varchar(60)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIPO_TOMA_TIERRA unique (TIPO_TOMA_TIERRA_ID) )
   ;

/*==============================================================*/
/* Table: TIRANTE                                               */
/*==============================================================*/
create table TIRANTE (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA734),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA735),
   PERIODO_STAR_ID      integer                        not null
      check (ASA736),
   TIRANTE_ID           numeric(10)                    not null
      check (ASA737),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA738)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA739)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA740)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA741)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA742)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA743)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TIRANTE unique (EMPRESA_ID, PERIODO_STAR, TIRANTE_ID),
   foreign key FK_TIRANTE_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_TIRANTE_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_TIRANTE_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_TIRANTE_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TOMA_TIERRA                                           */
/*==============================================================*/
create table TOMA_TIERRA (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA744),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA745),
   PERIODO_STAR_ID      integer                        not null
      check (ASA746),
   TOMA_TIERRA_ID       numeric(10)                    not null
      check (ASA747),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA748)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA749)),
   TIPO_TENSION_ID      numeric(2)                     null
      check (TIPO_TENSION_ID is null or (ASA750)),
   TIPO_TOMA_TIERRA_ID  numeric(2)                     null
      check (TIPO_TOMA_TIERRA_ID is null or (ASA751)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA752)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA753)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA754)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA755)),
   CODIGO_VNR           varchar(20)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TOMA_TIERRA unique (EMPRESA_ID, PERIODO_STAR, TOMA_TIERRA_ID),
   foreign key FK_TOMA_TIE_TIPO_TOM (TIPO_TOMA_TIERRA_ID)
         references TIPO_TOMA_TIERRA (TIPO_TOMA_TIERRA_ID)
         on update restrict,
   foreign key FK_TOMA_TIE_TIPO_TEN (TIPO_TENSION_ID)
         references TIPO_TENSION (TIPO_TENSION_ID)
         on update restrict,
   foreign key FK_TOMA_TIE_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_TOMA_TIE_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_TOMA_TIE_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_TOMA_TIE_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TRAMO_BT                                              */
/*==============================================================*/
create table TRAMO_BT (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA756),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA757),
   PERIODO_STAR_ID      integer                        not null
      check (ASA758),
   TRAMO_BT_ID          numeric(10)                    not null
      check (ASA759),
   TIPO_DISPOSICION_TRAMO_ID numeric(2)                     null
      check (TIPO_DISPOSICION_TRAMO_ID is null or (ASA760)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA761)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA762)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA763)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA764)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA765)),
   CODIGO_VNR           varchar(20)                    null,
   LARGO_RED            numeric(10)                    null
      check (LARGO_RED is null or (ASA766)),
   NUMERO_FASES         numeric(10)                    null
      check (NUMERO_FASES is null or (ASA767)),
   NOMBRE_FASES         varchar(5)                     null,
   PEEM_ID              numeric(10)                    null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TRAMO_BT unique (EMPRESA_ID, PERIODO_STAR, TRAMO_BT_ID),
   foreign key FK_TRAMO_BT_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_TRAMO_BT_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_TRAMO_BT_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict,
   foreign key FK_TRAMO_BT_TIPO_DIS (TIPO_DISPOSICION_TRAMO_ID)
         references TIPO_DISPOSICION_TRAMO (TIPO_DISPOSICION_TRAMO_ID)
         on update restrict,
   foreign key FK_TRAMO_BT_RELATIONS_NUMERO_F (NUMERO_FASES)
         references NUMERO_FASES (NUMERO_FASES)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TRAMO_MT                                              */
/*==============================================================*/
create table TRAMO_MT (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA768),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA769),
   PERIODO_STAR_ID      integer                        not null
      check (ASA770),
   TRAMO_MT_ID          numeric(10)                    not null
      check (ASA771),
   TIPO_DISPOSICION_TRAMO_ID numeric(2)                     null
      check (TIPO_DISPOSICION_TRAMO_ID is null or (ASA772)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA773)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA774)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA775)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA776)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA777)),
   CODIGO_VNR           varchar(20)                    null,
   LARGO_RED            numeric(10)                    null
      check (LARGO_RED is null or (ASA778)),
   NUMERO_FASES         numeric(10)                    null
      check (NUMERO_FASES is null or (ASA779)),
   NOMBRE_FASES         varchar(5)                     null,
   PEEM_ID              numeric(10)                    null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TRAMO_MT unique (EMPRESA_ID, PERIODO_STAR, TRAMO_MT_ID),
   foreign key FK_TRAMO_MT_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_TRAMO_MT_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_TRAMO_MT_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict,
   foreign key FK_TRAMO_MT_TIPO_DIS (TIPO_DISPOSICION_TRAMO_ID)
         references TIPO_DISPOSICION_TRAMO (TIPO_DISPOSICION_TRAMO_ID)
         on update restrict,
   foreign key FK_TRAMO_MT_RELATIONS_NUMERO_F (NUMERO_FASES)
         references NUMERO_FASES (NUMERO_FASES)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TRANSFORMADOR                                         */
/*==============================================================*/
create table TRANSFORMADOR (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA780),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA781),
   PERIODO_STAR_ID      integer                        not null
      check (ASA782),
   TRANSFORMADOR_ID     numeric(10)                    not null
      check (ASA783),
   NODO_ESQUEMATICO_ID  numeric(15)                    null
      check (NODO_ESQUEMATICO_ID is null or (ASA784)),
   COMUNA_ID            numeric(7)                     null
      check (COMUNA_ID is null or (ASA785)),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA786)),
   TIPO_RURALIDAD_ID    numeric(2)                     null
      check (TIPO_RURALIDAD_ID is null or (ASA787)),
   TIPO_PROPIEDAD_ID    numeric(2)                     null
      check (TIPO_PROPIEDAD_ID is null or (ASA788)),
   EN_ZONA_CONCESION    numeric(1)                     null
      check (EN_ZONA_CONCESION is null or (ASA789)),
   CONECTADA_RED        numeric(1)                     null
      check (CONECTADA_RED is null or (ASA790)),
   IDENTIFICADOR_VNR    varchar(30)                    null,
   FECHA_INSTALACION    timestamp                      null
      check (FECHA_INSTALACION is null or (ASA791)),
   CODIGO_VNR           varchar(20)                    null,
   KVA                  numeric(12,2)                  null
      check (KVA is null or (ASA792)),
   PEEM_ID              numeric(10)                    null,
   GIS_ID               numeric(15)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TRANSFORMADOR unique (EMPRESA_ID, PERIODO_STAR, TRANSFORMADOR_ID),
   foreign key FK_TRANSFOR_COMUNA (COMUNA_ID)
         references COMUNA (COMUNA_ID)
         on update restrict,
   foreign key FK_TRANSFOR_NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_TRANSFOR_TIPO_RUR (TIPO_RURALIDAD_ID)
         references TIPO_RURALIDAD (TIPO_RURALIDAD_ID)
         on update restrict,
   foreign key FK_TRANSFOR_EMPRESA (EMPRESA_ID)
         references EMPRESA (EMPRESA_ID)
         on update restrict,
   foreign key FK_TRANSFOR_TIPO_PRO (TIPO_PROPIEDAD_ID)
         references TIPO_PROPIEDAD (TIPO_PROPIEDAD_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: TRANSFORMADOR_INTERRUPCION                            */
/*==============================================================*/
create table TRANSFORMADOR_INTERRUPCION (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA793),
   INCIDENCIA_ID        numeric(10)                    not null,
   TRANSFORMADOR_ID     numeric(10)                    not null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   TIEMPO_INTERRUMPIDO  numeric(10)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_TRANSFORMADOR_INTERRUPCION unique (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, INTERRUPCION_ID, BLOQUE_REPOSICION_ID, TRANSFORMADOR_ID),
   foreign key FK_TRANSFOR_TRANSFOR (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, TRANSFORMADOR_ID)
         references TRANSFORMADOR_TOPOLOGIA (EMPRESA_ID, PERIODO_STAR, INCIDENCIA_ID, TRANSFORMADOR_ID)
         on update restrict,
   foreign key FK_TRANSFOR_BLOQUE_R (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID, BLOQUE_REPOSICION_ID)
         references BLOQUE_REPOSICION (EMPRESA_ID, PERIODO_STAR, INTERRUPCION_ID, BLOQUE_REPOSICION_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: T_CONSOLIDADO_INTERRUPCIONES                          */
/*==============================================================*/
create table T_CONSOLIDADO_INTERRUPCIONES (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA795),
   INTERRUPCION_ID      varchar(18)                    not null,
   CALIFICACION_INTERRUPCION_ID numeric(2)                     null,
   TIPO_ORIGEN_INTERRUPCION_ID numeric(2)                     null,
   SISTEMA_ELECTRICO_ID numeric(10)                    null,
   CAUSA_ID             numeric(5)                     null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   DURACION             numeric(10)                    null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   INCIDENCIA_ID        numeric(10)                    null,
   DESCRIPCION          varchar(100)                   null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   CANTIDAD_AFECTADOS   numeric                        null,
   TIEMPO_AFECTADOS     numeric                        null,
   CANTIDAD_TRAFOS      numeric                        null,
   TIEMPO               numeric                        null,
   POTENCIA_AFECTADA    numeric                        null,
   BLOQUE_VARIOS_ALIM   numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: T_CONSOLIDADO_INTERRUP_CGJ                            */
/*==============================================================*/
create table T_CONSOLIDADO_INTERRUP_CGJ (
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA796),
   EMPRESA_ID           numeric(3)                     not null,
   SIGLA                varchar(30)                    null,
   NOMBRE_REGION        varchar(100)                   null,
   INTERRUPCION_ID      varchar(18)                    not null,
   CALIFICACION         varchar(60)                    null,
   CAUSA                varchar(100)                   null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   NOMBRE_ALIMENTADOR   varchar(60)                    null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   CANTIDAD_AFECTADOS   numeric                        null,
   TIEMPO_AFECTADOS     numeric                        null,
   CANTIDAD_TRAFOS      numeric                        null,
   POTENCIA_AFECTADA    numeric                        null,
   KVA_INSTALADOS_R1    numeric                        null,
   KVA_INSTALADOS_R2    numeric                        null,
   KVA_INSTALADOS_U     numeric                        null,
   CLIENTES_BT1         numeric                        null,
   CLIENTES_OTROS_BT    numeric                        null,
   CLIENTES_AT          numeric                        null,
   CLIENTES_LIBRES      numeric                        null,
   TIEMPO_INTERRUPCION_HH numeric                        null,
   CANTIDAD_INTERRUPCIONES numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: T_CONSOLIDADO_INTERRUP_CGJ_01                         */
/*==============================================================*/
create table T_CONSOLIDADO_INTERRUP_CGJ_01 (
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA797),
   EMPRESA_ID           numeric(3)                     not null,
   SIGLA                varchar(30)                    null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   NOMBRE_REGION        varchar(100)                   null,
   CALIFICACION_INTERRUPCION varchar(60)                    null,
   CAUSA                varchar(100)                   null,
   CANTIDAD_PTOS_CONSUMOS numeric                        null,
   TIEMPO               numeric                        null,
   CANTIDAD_TRAFOS      numeric                        null,
   CANTIDAD_INTERRPCIONES numeric                        null,
   KVAS                 numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: T_CONSOLIDADO_INTERRUP_CGJ_02                         */
/*==============================================================*/
create table T_CONSOLIDADO_INTERRUP_CGJ_02 (
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA798),
   SIGLA                varchar(30)                    null,
   EMPRESA_ID           numeric(3)                     not null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   NOMBRE_ALIMENTADOR   varchar(60)                    null,
   NOMBRE_REGION        varchar(100)                   null,
   CALIFICACION_INTERRUPCION varchar(60)                    null,
   CAUSA                varchar(100)                   null,
   CLIENTES_AFECTADOS   numeric                        null,
   TIEMPO               numeric                        null,
   TRAFOS               numeric                        null,
   CANTIDAD_INTERRUPCIONES numeric                        null,
   KVAS                 numeric                        null,
   CLIENTES_BT1         numeric                        null,
   CLIENTES_OTROS_BT    numeric                        null,
   CLIENTES_AT          numeric                        null,
   CLIENTES_LIBRES      numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: T_CONSUMOS_AFECTADOS                                  */
/*==============================================================*/
create table T_CONSUMOS_AFECTADOS (
   EMPRESA_ID           numeric(3)                     not null,
   INCIDENCIA_ID        numeric(10)                    null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   CANTIDAD_AFECTADOS   numeric                        null,
   TOTAL_TIEMPO_AFECTADOS numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: T_INFO_BASE_INTERRUPCIONES                            */
/*==============================================================*/
create table T_INFO_BASE_INTERRUPCIONES (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA799),
   INTERRUPCION_ID      varchar(18)                    not null,
   CALIFICACION_INTERRUPCION_ID numeric(2)                     null,
   TIPO_ORIGEN_INTERRUPCION_ID numeric(2)                     null,
   SISTEMA_ELECTRICO_ID numeric(10)                    null,
   CAUSA_ID             numeric(5)                     null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   DURACION             numeric(10)                    null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   INCIDENCIA_ID        numeric(10)                    null,
   CAUSA                varchar(100)                   null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: T_POTENCIA_AFECTADA                                   */
/*==============================================================*/
create table T_POTENCIA_AFECTADA (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA800),
   INCIDENCIA_ID        numeric(10)                    not null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   ALIMENTADOR_INCIDENCIA_ID numeric(10)                    null,
   TIPO_RURALIDAD_ID    numeric(2)                     null,
   CANTIDAD_TRAFOS      numeric                        null,
   TIEMPO               numeric                        null,
   POTENCIA_AFECTADA    numeric                        null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: T_VW_INTERRUPCION_RESUMEN                             */
/*==============================================================*/
create table T_VW_INTERRUPCION_RESUMEN (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA801),
   TIPO_RURALIDAD_ID    numeric(2)                     not null,
   TIPO_RURALIDAD       varchar(60)                    null,
   INTERRUPCION_ID      varchar(18)                    not null,
   BLOQUE_REPOSICION_ID numeric(10)                    not null,
   FH_INICIO_INTERRUPCION timestamp                      null,
   ALIMENTADOR_ID       numeric(10)                    not null,
   NOMBRE_ALIMENTADOR   varchar(60)                    null,
   FH_TERMINO_BLOQUE    timestamp                      null,
   DURACION             numeric                        null,
   CANTIDAD_TRAFOS      numeric                        null,
   KVA_AFECTADOS        numeric                        null,
   CLIENTES_AFECTADOS   numeric                        null,
   BLOQUE_VARIOS_ALIM   numeric                        null,
   CAUSA                varchar(100)                   null,
   SUBCAUSA             varchar(100)                   null,
   CALIFICACION         varchar(60)                    null,
   MES_ANHO             varchar(8)                     null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: VERTICE_CANALIZACION                                  */
/*==============================================================*/
create table VERTICE_CANALIZACION (
   EMPRESA_ID           numeric(3)                     not null
      check (ASA802),
   PERIODO_STAR         varchar(6)                     not null
      check (ASA803),
   PERIODO_STAR_ID      integer                        not null
      check (ASA804),
   CANALIZACION_ID      numeric(10)                    not null
      check (ASA805),
   VERTICE_CANALIZACION_ID numeric(10)                    not null
      check (ASA806),
   NODO_IEC_ID          numeric(15)                    null
      check (NODO_IEC_ID is null or (ASA807)),
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   foreign key FK_VERTICE__NODO_IE2 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_VERTICE__CANALIZA (EMPRESA_ID, PERIODO_STAR, CANALIZACION_ID)
         references CANALIZACION (EMPRESA_ID, PERIODO_STAR, CANALIZACION_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: VERTICE_EMPALME                                       */
/*==============================================================*/
create table VERTICE_EMPALME (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA808),
   EMPALME_ID           numeric(10)                    not null,
   VERTICE_EMPALME_ID   numeric(10)                    not null,
   NODO_IEC_ID          numeric(15)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_VERTICE_EMPALME unique (EMPRESA_ID, PERIODO_STAR, EMPALME_ID, VERTICE_EMPALME_ID),
   foreign key FK_VERTICE__EMPALME (EMPRESA_ID, PERIODO_STAR, EMPALME_ID)
         references EMPALME (EMPRESA_ID, PERIODO_STAR, EMPALME_ID)
         on update restrict,
   foreign key FK_VERTICE__NODO_IE3 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict )
   ;

/*==============================================================*/
/* Table: VERTICE_TRAMO_BT                                      */
/*==============================================================*/
create table VERTICE_TRAMO_BT (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA809),
   TRAMO_BT_ID          numeric(10)                    not null,
   VERTICE_TRAMO_BT_ID  numeric(10)                    not null,
   NODO_IEC_ID          numeric(15)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_VERTICE_TRAMO_BT unique (EMPRESA_ID, PERIODO_STAR, TRAMO_BT_ID, VERTICE_TRAMO_BT_ID),
   foreign key FK_NODO_IEC_VERTICE_TRAM2 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_TRAMO_BT_VERTICE_TRAM1 (EMPRESA_ID, PERIODO_STAR, TRAMO_BT_ID)
         references TRAMO_BT (EMPRESA_ID, PERIODO_STAR, TRAMO_BT_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: VERTICE_TRAMO_MT                                      */
/*==============================================================*/
create table VERTICE_TRAMO_MT (
   EMPRESA_ID           numeric(3)                     not null,
   PERIODO_STAR         varchar(6)                     not null,
   PERIODO_STAR_ID      integer                        not null
      check (ASA810),
   TRAMO_MT_ID          numeric(10)                    not null,
   VERTICE_TRAMO_MT_ID  numeric(10)                    not null,
   NODO_IEC_ID          numeric(15)                    null,
   PEEM_ID              numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0,
   constraint PK_VERTICE_TRAMO_MT unique (EMPRESA_ID, PERIODO_STAR, TRAMO_MT_ID, VERTICE_TRAMO_MT_ID),
   foreign key FK_VERTICE__NODO_IE1 (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         references NODO_IEC (EMPRESA_ID, NODO_IEC_ID, PERIODO_STAR)
         on update restrict,
   foreign key FK_VERTICE__TRAMO_MT (EMPRESA_ID, PERIODO_STAR, TRAMO_MT_ID)
         references TRAMO_MT (EMPRESA_ID, PERIODO_STAR, TRAMO_MT_ID)
         on update restrict )
   ;

/*==============================================================*/
/* Table: VNR_CODIFICACION                                      */
/*==============================================================*/
create table VNR_CODIFICACION (
   TIPO_INSTALACION     varchar(30)                    null,
   CARACTER             numeric(3)                     null,
   LARGO                numeric(2)                     null,
   ITEM                 varchar(30)                    null,
   CODIGO               varchar(4)                     null,
   OPCION_CODIGO        varchar(50)                    null,
   ID                   numeric(10)                    null,
   tiene_errores        tinyint                        not null default 0 )
   ;

/*==============================================================*/
/* Table: errores                                               */
/*==============================================================*/
create table errores (
   d_rowid              integer                        not null,
   table_name           varchar(50)                    not null,
   constraint_name      varchar(50)                    not null,
   type                 varchar(50)                    not null )
   ;

/*==============================================================*/
/* Table: resumen_carga                                         */
/*==============================================================*/
create table resumen_carga (
   empresa_id           integer                        not null,
   periodo_star_id      integer                        not null,
   table_name           varchar(30)                    not null,
   registros_enviados   integer                        not null,
   registros_error      integer                        not null,
   registros_ok         integer                        not null )
   ;
