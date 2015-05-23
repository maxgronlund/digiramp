
FactoryGirl.define do
  factory :recording do
    title       Faker::Commerce.product_name
    artist      Faker::Name.name
    lyrics      Faker::Lorem.paragraph(4)
    bpm         Faker::Number.number(2).to_i
    comment     Faker::Lorem.paragraph(2)
    explicit    Faker::Number.number(2).to_i > 49
    version     1
    samplerate  44100
    user_id     1
    account_id  1
  end
end





#isrc_code",            limit: 255, default: ""
#artist",                           default: ""
#lyrics",                           default: ""
#bpm",                              default: 0
#comment",                          default: ""
#created_at",                                            null: false
#updated_at",                                            null: false
#account_id"
#explicit",                         default: false

#documents_count",                  default: 0,          null: false
#file_size",            limit: 255
#clearance",                        default: false
#version",              limit: 255
#copyright",                        default: ""
#production_company",   limit: 255, default: ""
#available_date"
#upc_code",             limit: 255, default: ""
#track_count"
#disk_number"
#disk_count"
#album_artist",         limit: 255
#album_title",          limit: 255
#grouping",             limit: 255
#composer",                         default: ""
#compilation"
#bitrate"
#samplerate"
#channels"
#audio_upload"
#completeness_in_pct",              default: 0
#mp3",                  limit: 255
#thumbnail",            limit: 255
#year",                 limit: 255, default: ""
#duration",                         default: 0.0
#album_name",                       default: ""
#genre",                            default: ""
#performer",                        default: ""
#band",                             default: ""
#disc",                 limit: 255, default: ""
#track",                limit: 255, default: ""
#waveform",             limit: 255, default: ""
#cover_art",            limit: 255
#cache_version",                    default: 0
#vocal",                limit: 255, default: ""
#import_batch_id"
#mood",                             default: ""
#instruments",                      default: ""
#tempo",                limit: 255, default: ""
#original_md5hash",     limit: 255, default: ""
#uuid",                 limit: 255
#artwork",              limit: 255, default: ""
#original_file",        limit: 255, default: ""
#image_file_id"
#ssl_url",              limit: 255, default: ""
#url",                  limit: 255, default: ""
#ext",                  limit: 255, default: ""
#original_file_name",   limit: 255, default: ""
#in_bucket",                        default: false
#zipp",                 limit: 255
#playbacks_count",                  default: 0
#likes_count",                      default: 0
#user_id"
#uniq_playbacks_count", limit: 255, default: ""
#uniq_likes_count",     limit: 255, default: ""
#privacy",              limit: 255, default: "Anyone"
#acceptance_of_terms"
#uniq_title",           limit: 255, default: ""
#fb_badge",             limit: 255
#downlodable",                      default: false
#featured",                         default: false
#orphan",                           default: false
#transfer_code",        limit: 255
#transferable",                     default: false
#position",                         default: 0
#featured_date"
#default_cover_art",    limit: 255, default: ""
#sounds_like",                      default: ""
#uniq_position"