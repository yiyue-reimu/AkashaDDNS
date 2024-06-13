add_languages("cxx20")
add_requires("nlohmann_json", "openssl3", "cpp-httplib", {config = {ssl = true}})

target("AkashaDDNS")
    add_includedirs("include")
    add_files("src/*.cpp")
    add_headerfiles("include/*.h", "include/*.hpp")
    set_pcxxheader("include/pch.h")
    add_packages("nlohmann_json", "openssl3", "cpp-httplib", {config = {ssl = true}})
target_end()