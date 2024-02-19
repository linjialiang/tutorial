./configure --prefix=/server/nginx \
--builddir=/package/nginx-1.24.0/build_nginx \

# 核心功能模块
--without-select_module \
--without-poll_module \
--with-threads \
--with-file-aio \

# 自带http功能模块全部启用
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module \
--with-http_image_filter_module \

--with-http_geoip_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_slice_module \
--with-http_stub_status_module \

# 外库路径
--with-pcre=/package/pcre2-10.43 \
--with-pcre-jit \
--with-zlib=/package/zlib-1.3.1 \
--with-openssl=/package/openssl-3.0.13
