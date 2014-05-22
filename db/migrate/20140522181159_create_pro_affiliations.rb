class CreateProAffiliations < ActiveRecord::Migration
  def change
    add_column :admins, :pro_affilications_uuid, :string, default: 'koda'
    
    create_table :pro_affiliations do |t|
      t.string :territory
      t.string :web
      t.string :title

      t.timestamps
    end
    
    ProAffiliation.find_or_create_by_title(:territory => 'Argentina',  :web => '', :title => "SADAIC")
    ProAffiliation.find_or_create_by_title(:territory => 'Australia',  :web => '', :title => "Australasian Performing Right Association (APRA)")
    ProAffiliation.find_or_create_by_title(:territory => 'Austria',  :web => '', :title => "Autoren, Komponisten und Musikverleger (AKM)")
    ProAffiliation.find_or_create_by_title(:territory => 'Belgium',  :web => '', :title => "SABAM")
    ProAffiliation.find_or_create_by_title(:territory => 'Brazil',  :web => '', :title => "ECAD (Escritório Central de Arrecadação e Distribuição)")
    ProAffiliation.find_or_create_by_title(:territory => 'Bulgaria',  :web => '', :title => "MUSICAUTHOR")
    ProAffiliation.find_or_create_by_title(:territory => 'Canada',  :web => '', :title => "Society of Composers, Authors and Music Publishers of Canada (SOCAN)")
    ProAffiliation.find_or_create_by_title(:territory => 'Chile',  :web => '', :title => "Sociedad Chilena del Derecho de Autor (SCD)")
    ProAffiliation.find_or_create_by_title(:territory => 'Colombia',  :web => '', :title => "SAYCO/ACINPRO")
    ProAffiliation.find_or_create_by_title(:territory => 'Croatia',  :web => '', :title => "HDS")
    ProAffiliation.find_or_create_by_title(:territory => 'Czech',  :web => '', :title => "Republic	OSA")
    ProAffiliation.find_or_create_by_title(:territory => 'Denmark',  :web => '', :title => "KODA")
    ProAffiliation.find_or_create_by_title(:territory => 'Estonia',  :web => '', :title => "EAU")
    ProAffiliation.find_or_create_by_title(:territory => 'Finland',  :web => '', :title => "Teosto")
    ProAffiliation.find_or_create_by_title(:territory => 'France',  :web => '', :title => "Société des auteurs, compositeurs et éditeurs de musique (SACEM)")
    ProAffiliation.find_or_create_by_title(:territory => 'Georgia',  :web => '', :title => "SAS")
    ProAffiliation.find_or_create_by_title(:territory => 'Germany',  :web => '', :title => "Gesellschaft für musikalische Aufführungs- und mechanische Vervielfältigungsrechte (GEMA)")
    ProAffiliation.find_or_create_by_title(:territory => 'Greece',  :web => '', :title => "AEPI")
    ProAffiliation.find_or_create_by_title(:territory => 'Hong Kong',  :web => '', :title => "CASH")
    ProAffiliation.find_or_create_by_title(:territory => 'Hungary',  :web => '', :title => "ARTISJUS")
    ProAffiliation.find_or_create_by_title(:territory => 'Ireland',  :web => '', :title => "Irish Music Rights Organisation, PPI")
    ProAffiliation.find_or_create_by_title(:territory => 'Israel',  :web => '', :title => "ACUM")
    ProAffiliation.find_or_create_by_title(:territory => 'Italy',  :web => '', :title => "SIAE")
    ProAffiliation.find_or_create_by_title(:territory => 'Japan',  :web => '', :title => "JASRAC")
    ProAffiliation.find_or_create_by_title(:territory => 'Korea',  :web => '', :title => "KOMCA")
    ProAffiliation.find_or_create_by_title(:territory => 'Lithuania',  :web => '', :title => "LATGA-A")
    ProAffiliation.find_or_create_by_title(:territory => 'Malaysia',  :web => '', :title => "MACP")
    ProAffiliation.find_or_create_by_title(:territory => 'Mexico',  :web => '', :title => "SACM")
    ProAffiliation.find_or_create_by_title(:territory => 'Netherlands',  :web => '', :title => "BUMA")
    ProAffiliation.find_or_create_by_title(:territory => 'New Zealand',  :web => '', :title => "APRA")
    ProAffiliation.find_or_create_by_title(:territory => 'Norway',  :web => '', :title => "TONO")
    ProAffiliation.find_or_create_by_title(:territory => 'Panama',  :web => '', :title => "SPAC")
    ProAffiliation.find_or_create_by_title(:territory => 'Peru',  :web => '', :title => "APDAYC")
    ProAffiliation.find_or_create_by_title(:territory => 'Philippines',  :web => '', :title => "FILSCAP")
    ProAffiliation.find_or_create_by_title(:territory => 'Poland',  :web => '', :title => "ZAIKS")
    ProAffiliation.find_or_create_by_title(:territory => 'Puerto Rico',  :web => '', :title => "ACEMLA")
    ProAffiliation.find_or_create_by_title(:territory => 'Romania',  :web => '', :title => "UCMR")
    ProAffiliation.find_or_create_by_title(:territory => 'Russia',  :web => '', :title => "RAO")
    ProAffiliation.find_or_create_by_title(:territory => 'Serbia',  :web => '', :title => "SOKOJ")
    ProAffiliation.find_or_create_by_title(:territory => 'Singapore',  :web => '', :title => "COMPASS")
    ProAffiliation.find_or_create_by_title(:territory => 'Slovakia',  :web => '', :title => "SOZA")
    ProAffiliation.find_or_create_by_title(:territory => 'South Africa',  :web => '', :title => "SAMRO")
    ProAffiliation.find_or_create_by_title(:territory => 'Spain',  :web => '', :title => "SGAE")
    ProAffiliation.find_or_create_by_title(:territory => 'Sweden',  :web => '', :title => "STIM")
    ProAffiliation.find_or_create_by_title(:territory => 'Switzerland',  :web => '', :title => "SUISA")
    ProAffiliation.find_or_create_by_title(:territory => 'Taiwan',  :web => '', :title => "MUST")
    ProAffiliation.find_or_create_by_title(:territory => 'Thailand',  :web => '', :title => "MCT")
    ProAffiliation.find_or_create_by_title(:territory => 'Trinidad',  :web => '', :title => "COTT")
    ProAffiliation.find_or_create_by_title(:territory => 'Ukraine',  :web => '', :title => "UACRR")
    ProAffiliation.find_or_create_by_title(:territory => 'United Kingdom',  :web => '', :title => "PRS")
    ProAffiliation.find_or_create_by_title(:territory => 'United Kingdom',  :web => '', :title => "PPL")
    ProAffiliation.find_or_create_by_title(:territory => 'United States',  :web => 'http://www.ascap.com/', :title => "ASCAP")
    ProAffiliation.find_or_create_by_title(:territory => 'United States',  :web => '', :title => "BMI")
    ProAffiliation.find_or_create_by_title(:territory => 'United States',  :web => '', :title => "SESAC")
    ProAffiliation.find_or_create_by_title(:territory => 'United States',  :web => '', :title => "ACEMLA (SPACEM)")
    ProAffiliation.find_or_create_by_title(:territory => 'Uruguay',  :web => '', :title => "AGADU")
    ProAffiliation.find_or_create_by_title(:territory => 'Venezuela',  :web => '', :title => "SACVEN")
    
    
  end
end
