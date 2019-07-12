# wordpress woocommrece 相关记录

1. flatsome主题，先找主题文件，没有再找插件的文件
2. 查询种类列表，/wp-include/category-template.php 
3. 数据库查询前，D:\coding\php\wwwroot\esrgear.com\wp-includes\taxonomy.php
4. add_filter('func1', 'func_callback', $priority, arg1, arg2...)，先调用func1，再调用回调函数func_callback，传给回调函数的参数是arg1...
	$priority：可选（整型）。用于指定与特定的动作相关联的函数的执行顺序。数字越小，执行越早，默认值 10
5. add_action()类似add_filter()
6. Redis Object Cache插件，可实现WordPress支持Redis
7. Pages页面添加中有Visual / Text 写html用Text
8. category 分类相关：
	1、商城分类列表在plugins\woocommerce\includes\widgets\class-wc-widget-product-categories.php文件中调用wp_list_categories方法进行查询数据并输出html
	2、wp-content\plugins\woocommerce\includes\widgets\class-wc-widget-product-categories.php中widget函数
		先找出一级parent的term_id，再找出二级parent的term_id, 最后合起来所有的term_id


9. 主题js特效修改文件： flatsome-child\core_new.js
10. esr_terms分类表，esr_term_taxonomy子类与父类关系表
11. 购物车相关：
	1、添加购物车模板文件：woocommerce\templates\single-product\add-to-cart\variation-add-to-cart-button.php
	2、includes\class-woocommerce.php(init函数) => woocommerce\includes\class-wc-form-handler.php(add_to_cart_action函数) 
		=> class-wc-form-handler.php(add_to_cart_handler_variable函数)
		=> plugins\woocommerce\includes\class-wc-cart.php(add_to_cart函数)
		=> 
	3、购物车数据标志存到cookie中， key=woocommerce_cart_hash and key=woocommerce_items_in_cart
		woocommerce\includes\class-wc-cart-session.php （set_cart_cookies函数）
	4、购物车数据存到session中，includes\class-wc-cart-session.php (set_session函数)
	5、提交购物车表单参数：
		attribute_color: Clear
		quantity: 1
		gtm4wp_id: 12814
		gtm4wp_name: Galaxy S10 Plus Mimic Tempered Glass Case
		gtm4wp_sku: 12814
		gtm4wp_category: Samsung Galaxy S10 Plus
		gtm4wp_price: 18.99
		gtm4wp_currency: USD
		gtm4wp_stocklevel: 
		add-to-cart: 12814
		product_id: 12814
		variation_id: 12823


12. 图片相关：
	1、Page页， Product页进行上传
	2、详情页展示图片：
		themes\flatsome\woocommerce\single-product\product-image.php(wc_get_template_part函数)
		=> plugins\woocommerce\includes\wc-core-functions.php(load_template函数)
		=> wp-includes\template.php(require函数)
	3、获取图片文件path:
		wp-includes\functions.php (_wp_upload_dir函数) 图片文件夹的 年/月 没有传time则获取当前时间
	4、WP_CONTENT_URL配置文件url , 也可配置 option: upload_url_path pre_options表改
	5、详情页小图模板文件 flatsome\woocommerce\single-product\product-image-vertical.php
	6、通过附件ID获取url wp-includes\media.php 文件中 wp_get_attachment_image_src函数 再由wp_get_attachment_url函数
	7、wp-includes\post.php 中 get_post() 中 WP_Post::get_instance( $post );获取image信息
	8、wp-includes\class-wp-post.php get_instance函数获取数据库数据（有缓存），image_url就有了,为esr_post表中guid字段
		sql: SELECT * FROM $wpdb->posts WHERE ID = %d LIMIT 1", $post_id

	9、另一种获取image url方式，（$file = get_post_meta( $post->ID, '_wp_attached_file', true ) get_post_meta()获取到file含年月，再与第3部中的baseurl拼起来
		wp-includes\meta.php文件 中update_meta_cache函数，
		执行sql语句 SELECT post_id, meta_key, meta_value FROM esr_postmeta WHERE post_id IN (10379) ORDER BY meta_id ASC 当meta_key='_wp_attached_file'时，
		meta_value即为文件路径如：2018/11/iPhone-87-Metal-Kickstand-Case-black.jpg


	10、上传图片调用接口 http://local.wp.com/wp-admin/async-upload.php
		formData: 
			name: 屏幕截图(1).png
			action: upload-attachment
			_wpnonce: 43bd5b5f72
			post_id: 16593
			async-upload: (binary)

		includes\media.php中media_handle_upload()=>wp_handle_upload() 存储图片
		最终存到pre_post、pre_postmeta表中，图片信息也就在表中存储
	11、获取图片地址：
		wp_get_attachment_image_src( )

	

13. 购物车checkout页面：
	1、flatsome\woocommerce\checkout\form-checkout.php
	2、includes\wc-template-hooks.php add_action 了woocommerce_order_review函数渲染订单信息，woocommerce_checkout_payment函数付款银行信息
	3、右侧页面模板文件：flatsome\woocommerce\checkout\review-order.php
	4、WC()->cart->get_cart()可以获取到购物车信息


14. 订单相关：
	1、后台订单列表
		生成订单列表 woocommerce\includes\admin\list-tables\class-wc-admin-list-table-orders.php的render_order_number_column函数
	2、下单页面模板文件：
		wp-content\plugins\woocommerce\templates\checkout\payment.php
	3、下单ajax提交：
		地址：http://local.wp.com/?wc-ajax=checkout
		参数：
			billing_first_name: Mince
			billing_last_name: Zhao
			billing_country: US
			billing_address_1: test
			billing_address_2: test
			billing_city: test
			billing_state: AK
			billing_postcode: 12345
			billing_phone: 18612345678
			billing_email: mince.zhao@esrtech.cn
			order_comments: 
			shipping_method[0]: flat_rate:3
			payment_method: paypal
			wc-stripe-payment-token: new
			woocommerce-process-checkout-nonce: 75b8334a6c
			_wp_http_referer: /?wc-ajax=update_order_review

		保存成功后返回paypal付款地址，跳转到paypal付款

15. autoptimize页面脚本优化插件：
	注意：优化JAVASCRIPT代码这个选项也是很重要的，但刚开始时使用Autoptimize，先不要勾选，主要是怕js导致网站出错(HTML和CSS的一个规则是前后顺序，不易出错，而JS则是程序逻辑，还有DOM结构不能混乱)。在前两项生效后，你可以把这项选择上，然后看网站会不会出现什么不正常（主要是功能方面）。如果出现错误，则取消勾选，否则，就一路优化到底吧。

16. 头部nav:
	wp-content\themes\flatsome\template-parts\header\header-main.php
	wp-content\themes\flatsome\inc\structure\structure-header.php
	wp-includes\nav-menu-template.php 中wp_nav_menu函数输入html

17. wp_posts 与 wp_terms表关系：
	select * from esr_postmeta where meta_key = '_menu_item_object_id'; 中的meta_value与wp_terms的ID关联


18. 国家地区相关：
	1. 模板文件：
		wp-content\plugins\woocommerce-product-price-based-on-countries\includes\class-wcpbc-widget-country-selector.php
		wp-content\plugins\woocommerce-product-price-based-on-countries\templates\country-selector.php
	2. 获取ip:
		wp-content\plugins\redirection\models\request.php
		wp-content\plugins\woocommerce\includes\wc-core-functions.php中wc_get_customer_default_location函数 中 WC_Geolocation::geolocate_ip根据ip获取
		wp-content\plugins\woocommerce\includes\class-wc-geolocation.php 用ip在maxmind db文件中查询国家信息 （https://dev.maxmind.com/geoip/geoip2/geolite2/）
	3. 选择的国家或者默认进来的国家，存到session中, wp_woocommerce_sessions表
	4. 登录账号设置过国家后，再次登录还是这个国家
	5. 国家显示异常，取得数据是$this->changes
	6. 存到session中，如果没过去，ip变了，国家不会变
	7. 唯一客户ID存在浏览器cookie key：wp_woocommerce_session_* , 清掉即可变更session


20. 评论相关：
	1、主表：wp_comments
	2、

21. form表单：
	1、表单模板在wp_posts表post_type='wpcf7_contact_form'中
	2、表单的内容保存后存放到wp_db7_forms表中
	3、表单使用的插件是：Contact Form 7

22. 产品相关：
	1、
	