<?php

if ( ! isset( $content_width ) )
	$content_width = 640; /* pixels */

if ( ! function_exists( 'minisch_setup' ) ):
/**
 * Sets up theme defaults and registers support for various WordPress features.
 *
 * Note that this function is hooked into the after_setup_theme hook, which runs
 * before the init hook. The init hook is too late for some features, such as indicating
 * support post thumbnails.
 *
 * To override minisch_setup() in a child theme, add your own minisch_setup to your child theme's
 * functions.php file.
 */
function minisch_setup() {
	/**
	 * Make theme available for translation
	 * Translations can be filed in the /languages/ directory
	 * If you're building a theme based on minisch, use a find and replace
	 * to change 'minisch' to the name of your theme in all the template files
	 */
	load_theme_textdomain( 'minisch', get_template_directory() . '/languages' );

	$locale = get_locale();
	$locale_file = get_template_directory() . "/languages/$locale.php";
	if ( is_readable( $locale_file ) )
		require_once( $locale_file );

	/**
	 * Add default posts and comments RSS feed links to head
	 */
	add_theme_support( 'automatic-feed-links' );

	add_theme_support( 'post-thumbnails', array( 'post' ) );

	add_theme_support( 'post-formats', array( 'standard', 'aside', 'gallery' ) );
}
endif; // minisch_setup

if ( function_exists( 'add_theme_support' ) ) {
	add_theme_support( 'post-thumbnails' );
        set_post_thumbnail_size( 700, 230, true );
}

// Load up our awesome theme options
require_once ( get_stylesheet_directory() . '/theme-options.php' );

// gets included in the site header
function header_style() {
    ?><style type="text/css">
        a.accueil {
		background: url(<?php header_image(); ?>) no-repeat center center;
        }
    </style><?php
}

// gets included in the admin header
function admin_header_style() {
    ?><style type="text/css">
        #headimg {
            width: <?php echo HEADER_IMAGE_WIDTH; ?>px;
            height: <?php echo HEADER_IMAGE_HEIGHT; ?>px;
            background-repeat: no-repeat;
        }
    </style><?php
}


/**
 * Tell WordPress to run minisch_setup() when the 'after_setup_theme' hook is run.
 */
add_action( 'after_setup_theme', 'minisch_setup' );

/**
 * Set a default theme color array for WP.com.
 */
$themecolors = array(
	'bg' => 'ffffff',
	'border' => 'eeeeee',
	'text' => '444444',
);

/**
 * Get our wp_nav_menu() fallback, wp_page_menu(), to show a home link.
 */
function minisch_page_menu_args( $args ) {
	$args['show_home'] = true;
	return $args;
}
add_filter( 'wp_page_menu_args', 'minisch_page_menu_args' );

/**
 * Register widgetized area and update sidebar with default widgets
 */
function minisch_widgets_init() {
	register_sidebar( array(
		'name' => __( 'Sidebar 1', 'minisch' ),
		'id' => 'sidebar-1',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h1 class="widget-title">',
		'after_title' => '</h1>',
	) );

	register_sidebar( array(
		'name' => __( 'Footer', 'minisch' ),
		'id' => 'footer-2',
		'description' => __( 'Yes, you can even put widgets in your Footer !', 'minisch' ),
		'before_widget' => '<aside id="%1$s" class="widget widget-footer %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h1 class="widget-title">',
		'after_title' => '</h1>',
	) );

	register_sidebar( array(
		'name' => __( 'Archives Page', 'minisch' ),
		'id' => 'archives',
		'description' => __( 'Edit your Archives page. Included in Minisch, you can enable it by creating a new empty page named "Archives", from Wordpress administration. Then add a link in your menu.', 'minisch' ),
		'before_widget' => '<section id="%1$s" class="widget %2$s">',
		'after_widget' => "</section>",
		'before_title' => '<h1 class="widget-title">',
		'after_title' => '</h1>',
	) );
}
add_action( 'init', 'minisch_widgets_init' );

if ( ! function_exists( 'minisch_content_nav' ) ):
/**
 * Display navigation to next/previous pages when applicable
 *
 * @since minisch 1.2
 */
function minisch_content_nav( $nav_id ) {
	global $wp_query;

	?>
	<nav id="<?php echo $nav_id; ?>">
		<h1 class="assistive-text section-heading"><?php _e( 'Post navigation', 'minisch' ); ?></h1>

	<?php if ( is_single() ) : // navigation links for single posts ?>

		<?php previous_post_link( '<div class="nav-previous">%link</div>', '<span class="meta-nav">' . _x( '&larr;', 'Previous post link', 'minisch' ) . '</span> %title' ); ?>
		<?php next_post_link( '<div class="nav-next">%link</div>', '%title <span class="meta-nav">' . _x( '&rarr;', 'Next post link', 'minisch' ) . '</span>' ); ?>

	<?php elseif ( $wp_query->max_num_pages > 1 && ( is_home() || is_archive() || is_search() ) ) : // navigation links for home, archive, and search pages ?>

		<?php if ( get_next_posts_link() ) : ?>
		<div class="nav-previous"><?php next_posts_link( __( '<span class="meta-nav">&larr;</span> Older posts', 'minisch' ) ); ?></div>
		<?php endif; ?>

		<?php if ( get_previous_posts_link() ) : ?>
		<div class="nav-next"><?php previous_posts_link( __( 'Newer posts <span class="meta-nav">&rarr;</span>', 'minisch' ) ); ?></div>
		<?php endif; ?>

	<?php endif; ?>

	</nav><!-- #<?php echo $nav_id; ?> -->
	<?php
}
endif; // minisch_content_nav


if ( ! function_exists( 'minisch_comment' ) ) :
/**
 * Template for comments and pingbacks.
 *
 * To override this walker in a child theme without modifying the comments template
 * simply create your own minisch_comment(), and that function will be used instead.
 *
 * Used as a callback by wp_list_comments() for displaying the comments.
 *
 * @since minisch 0.4
 */
function minisch_comment( $comment, $args, $depth ) {
	$GLOBALS['comment'] = $comment;
	switch ( $comment->comment_type ) :
		case 'pingback' :
		case 'trackback' :
	?>
	<li class="post pingback">
		<p><?php _e( 'Pingback:', 'minisch' ); ?> <?php comment_author_link(); ?><?php edit_comment_link( __( '(Edit)', 'minisch' ), ' ' ); ?></p>
	<?php
			break;
		default :
	?>
	<li <?php comment_class(); ?> id="li-comment-<?php comment_ID(); ?>">
		<article id="comment-<?php comment_ID(); ?>" class="comment">

			<header>
				<div class="comment-author vcard">
					<?php echo get_avatar( $comment, 40 ); ?>
					<?php printf( __( '%s', 'minisch' ), sprintf( '<cite class="fn">%s,</cite>', get_comment_author_link() ) ); ?>
				</div><!-- .comment-author .vcard -->
				<?php if ( $comment->comment_approved == '0' ) : ?>
					<br>
					<em><?php _e( 'Your comment is waiting for moderation', 'minisch' ); ?></em>
				<?php endif; ?>

				<div class="comment-meta commentmetadata">
					<a href="<?php echo esc_url( get_comment_link( $comment->comment_ID ) ); ?>"><time pubdate datetime="<?php comment_time( 'c' ); ?>">
					<?php _e('on', 'minisch'); ?><?php printf( __( ' <strong>%s</strong>', 'minisch' ), get_comment_date() ); ?>
					<?php _e('at', 'minisch'); ?><?php printf( __( ' <strong>%s</strong>', 'minisch' ), get_comment_time() ); ?>
					</time></a>
					<?php edit_comment_link( __( '(Edit)', 'minisch' ), ' ' );
					?>
				</div><!-- .comment-meta .commentmetadata -->

				<div class="reply">
					<?php comment_reply_link( array_merge( $args, array( 'depth' => $depth, 'max_depth' => $args['max_depth'] ) ) ); ?>
				</div><!-- .reply -->
			</header>

			<div class="comment-content"><?php comment_text(); ?></div>
		</article><!-- #comment-## -->

	<?php
			break;
	endswitch;
}
endif; // ends check for minisch_comment()

if ( ! function_exists( 'minisch_posted_on' ) ) :
/**
 * Prints HTML with meta information for the current post-date/time and author.
 * Create your own minisch_posted_on to override in a child theme
 *
 * @since minisch 1.2
 */
function minisch_posted_on() {
	printf( __( '<a href="%1$s" title="%2$s" rel="bookmark"><time class="entry-date" datetime="%3$s" pubdate>%4$s</time></a><span class="byline"> <span class="sep"> par </span> <span class="author vcard"><a class="url fn n" href="%5$s" title="%6$s" rel="author">%7$s</a></span></span>', 'minisch' ),
		esc_url( get_permalink() ),
		esc_attr( get_the_time() ),
		esc_attr( get_the_date( 'c' ) ),
		esc_html( get_the_date() ),
		esc_url( get_author_posts_url( get_the_author_meta( 'ID' ) ) ),
		esc_attr( sprintf( __( 'View all posts by %s', 'minisch' ), get_the_author() ) ),
		esc_html( get_the_author() )
	);
}
endif;

/**
 * Adds custom classes to the array of body classes.
 *
 * @since minisch 1.2
 */
function minisch_body_classes( $classes ) {
	// Adds a class of single-author to blogs with only 1 published author
	if ( ! is_multi_author() ) {
		$classes[] = 'single-author';
	}

	return $classes;
}
add_filter( 'body_class', 'minisch_body_classes' );

/**
 * Returns true if a blog has more than 1 category
 *
 * @since minisch 1.2
 */
function minisch_categorized_blog() {
	if ( false === ( $all_the_cool_cats = get_transient( 'all_the_cool_cats' ) ) ) {
		// Create an array of all the categories that are attached to posts
		$all_the_cool_cats = get_categories( array(
			'hide_empty' => 1,
		) );

		// Count the number of categories that are attached to the posts
		$all_the_cool_cats = count( $all_the_cool_cats );

		set_transient( 'all_the_cool_cats', $all_the_cool_cats );
	}

	if ( '1' != $all_the_cool_cats ) {
		// This blog has more than 1 category so minisch_categorized_blog should return true
		return true;
	} else {
		// This blog has only 1 category so minisch_categorized_blog should return false
		return false;
	}
}

/**
 * Flush out the transients used in minisch_categorized_blog
 *
 * @since minisch 1.2
 */
function minisch_category_transient_flusher() {
	// Like, beat it. Dig?
	delete_transient( 'all_the_cool_cats' );
}
add_action( 'edit_category', 'minisch_category_transient_flusher' );
add_action( 'save_post', 'minisch_category_transient_flusher' );

/**
 * Filter in a link to a content ID attribute for the next/previous image links on image attachment pages
 */
function minisch_enhanced_image_navigation( $url ) {
	global $post;

	if ( wp_attachment_is_image( $post->ID ) )
		$url = $url . '#main';

	return $url;
}
add_filter( 'attachment_link', 'minisch_enhanced_image_navigation' );


function get_archives_link_mod ( $link_html ) {
   preg_match ("/href='(.+?)'/", $link_html, $url);
   $requested = "http://{$_SERVER['SERVER_NAME']} {$_SERVER['REQUEST_URI']}";
      if ($requested == $url[1]) {
         $link_html = str_replace("<li>", "<li class='current'>", $link_html);
      }
      return $link_html;
   }

add_filter("wp_get_archives", "get_archives_link_mod");

function aside_excerpt($excerpt_length = 55, $id = false, $echo = true) {
         
    $text = '';
   
          if($id) {
                $the_post = & get_post( $my_id = $id );
                $text = ($the_post->post_excerpt) ? $the_post->post_excerpt : $the_post->post_content;
          } else {
                global $post;
                $text = ($post->post_excerpt) ? $post->post_excerpt : get_the_content('');
    }
         
                $text = strip_shortcodes( $text );
                $text = apply_filters('the_content', $text);
                $text = str_replace(']]>', ']]&gt;', $text);
          $text = strip_tags($text);
       
                $excerpt_more = ' ' . '…';
                $words = preg_split("/[\n\r\t ]+/", $text, $excerpt_length + 1, PREG_SPLIT_NO_EMPTY);
                if ( count($words) > $excerpt_length ) {
                        array_pop($words);
                        $text = implode(' ', $words);
                        $text = $text . $excerpt_more;
                } else {
                        $text = implode(' ', $words);
                }
        if($echo)
  echo apply_filters('the_content', $text);
        else
        return $text;
}
function get_aside_excerpt($excerpt_length = 55, $id = false, $echo = false) {
 return my_excerpt($excerpt_length, $id, $echo);
}

function custom_excerpt_length( $length ) {
	return 40;
}
add_filter( 'excerpt_length', 'custom_excerpt_length', 999 );

function new_excerpt_more($more) {
	return '…';
}
add_filter('excerpt_more', 'new_excerpt_more');

add_custom_background();

/* Création d'un nouveau menu personnalisé */
	add_theme_support( 'menus' );
		if ( function_exists( 'register_nav_menus' ) ) {
		register_nav_menus(
		array('menuprincipal' => 'Menu Principal')
);
}

define('HEADER_TEXTCOLOR', '');
define('NO_HEADER_TEXT', true );
define('HEADER_IMAGE', '%s/logodefault.png'); // %s is the template dir uri
define('HEADER_IMAGE_WIDTH', 200); // use width and height appropriate for your theme
define('HEADER_IMAGE_HEIGHT', 60);

add_custom_image_header('header_style', 'admin_header_style');

/**
 * This theme was built with PHP, Semantic HTML, CSS, love, and a minisch.
 */
