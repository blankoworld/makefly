<?php
/**
 * The Header for our theme.
 *
 * Displays all of the <head> section and everything up till <div id="main">
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */
?><!DOCTYPE html>
<!--[if IE 6]>
<html id="ie6" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 7]>
<html id="ie7" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 8]>
<html id="ie8" <?php language_attributes(); ?>>
<![endif]-->
<!--[if !(IE 6) | !(IE 7) | !(IE 8)  ]><!-->
<html <?php language_attributes(); ?>>
<!--<![endif]-->

<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>">
	<meta name="viewport" content="width=device-width">
<title><?php
	/*
	 * Print the <title> tag based on what is being viewed.
	 */
	global $page, $paged;

	wp_title( '|', true, 'right' );

	// Add the blog name.
	bloginfo( 'name' );

	// Add the blog description for the home/front page.
	$site_description = get_bloginfo( 'description', 'display' );
	if ( $site_description && ( is_home() || is_front_page() ) )
		echo " | $site_description";

	// Add a page number if necessary:
	if ( $paged >= 2 || $page >= 2 )
		echo ' | ' . sprintf( __( 'Page %s', 'minisch' ), max( $paged, $page ) );

	?></title>
	<meta name="description" content="<?php bloginfo('description'); ?>">
	<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">

	<!-- Styles -->
	<link rel="stylesheet" type="text/css" media="all" href="<?php bloginfo( 'stylesheet_url' ); ?>">

	<?php $options = get_option('minisch_theme_options'); ?>
	<?php if ( $options['titreligne1'] ) : ?>
		<style type="text/css">
			header#joliebarre a.accueil {
				display: block;
			}
		</style>
	<?php endif; ?>

	<?php if ( $options['imgmax'] ) : ?>
		<style type="text/css">
			section#flux .attachment-post-thumbnail {
				max-height: <?php if ( $options['imgmax'] ) : ?><?php echo $options['imgmax']; ?><?php else : ?>200px<?php endif; ?>;
			}
		</style>
	<?php endif; ?>

	<?php if ( $options['colonne1'] ) : ?>
		<style type="text/css">
			body.single aside#laterale,
			body.page aside#laterale {
			    padding-top: 26px;
			}
		@media screen and (min-width:850px) {
			body.single aside#laterale,
			body.page aside#laterale {
			    width: 21%; }

			body.single section#flux,
			body.page section#flux {
			    display: inline-block;
			    float: right;
			    width: 74%;
			    margin: 5.5px auto;
		} }
			body.page-template-archives-php section#flux { width: 100%; float: none; }
		</style>
	<?php endif; ?>

		<style type="text/css">
			li.bypostauthor > article.comment .comment-author cite:after {
			    content: "<?php _e('author', 'minisch'); ?>";
			}
		</style>

	<?php if ( $options['positioncolonne'] == "1" ) : ?>
		<style type="text/css">
			aside#laterale {
			    display: inline-block;
			    float: right;
			    padding: 0 0 20px 2%;
			}
		<?php if ( $options['colonne1'] ) : ?>
			body.single section#flux,
			body.page section#flux {
			    display: inline-block;
			    float: left;
			    margin: 0 auto;
			    padding: 0;
			    vertical-align: top;
			}
		<?php endif; ?>
		</style>
	<?php endif; ?>

	<!-- Commentaires -->
	<?php if ( is_singular() && get_option( 'thread_comments' ) ) wp_enqueue_script( 'comment-reply' ); ?>
	<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">

	<!-- Script JQuery -->
	<script src="<?php echo get_template_directory_uri(); ?>/js/jquery.js" type="text/javascript"></script>

<!--[if lt IE 9]>
<script src="<?php echo get_template_directory_uri(); ?>/js/html5.js" type="text/javascript"></script>
<![endif]-->

<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
	<header id="joliebarre">
		<section>

		<?php $options = get_option('minisch_theme_options'); ?>
		<?php if ( $options['nohead1'] ) : ?>
		<?php else : ?>
			<a class="accueil" href="<?php echo get_option('home'); ?>">

				<?php $options = get_option('minisch_theme_options'); ?>
				<?php if ( $options['titre1'] ) : ?>

					<?php if ( $options['titre'] ) : ?>
						<?php
						    $options = get_option('minisch_theme_options');
						    echo $options['titre'];
			      			?>
					<?php else : ?>
						<?php bloginfo('name'); ?>
					<?php endif; ?>

				<?php endif; ?>
			</a>
		<?php endif; ?>

			<nav>
		<?php if ( $options['recherche1'] ) : ?>
		<?php else : ?>
				<form role="search" method="get" id="searchform" action="<?php echo get_option('home'); ?>">
					<div>
						<label class="screen-reader-text" for="s"><?php _e('Search for: ', 'minisch'); ?></label>
						<input type="text" placeholder="<?php _e('Search...', 'minisch'); ?>" value="" name="s" id="s">
						<input type="submit" id="searchsubmit" value="Recherche">
					</div>
				</form>
		<?php endif; ?>

		<?php if ( $options['home1'] ) : ?>
		<?php else : ?>
                       		<li class="home">
					<a class="home" href="<?php echo get_option('home'); ?>"><span></span></a>
				</li>
		<?php endif; ?>
				<?php wp_nav_menu( array('theme_location' => 'menuprincipal', 'items_wrap' => '%3$s' )); ?>
		<?php if ( $options['rss1'] ) : ?>
		<?php else : ?>
				<li>
					<a href="<?php bloginfo_rss('rss2_url') ?>" class="follow rss"><span></span>RSS</a>
					<ul class="sub-menu">
						<li><a class="follow rss" href="<?php bloginfo_rss('rss_url') ?>"><span></span>RSS 0.92</a></li>
						<li><a class="follow rss" href="<?php bloginfo_rss('rss2_url') ?>"><span></span><?php _e('RSS 2.0 Feed', 'minisch'); ?></a></li>
						<li><a class="follow rss" href="<?php bloginfo_rss('atom_url') ?>"><span></span><?php _e('Atom Feed', 'minisch'); ?></a></li>
						<li><a class="follow rss" href="<?php bloginfo_rss('comments_rss2_url') ?>"><span></span><?php _e('Comments', 'minisch'); ?></a></li>
					</ul>
				</li>
		<?php endif; ?>
			</nav>
		</section>
	</header>

<div id="conteneur">
