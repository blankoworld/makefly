<?php
/**
 * The template for displaying all pages.
 *
 * This is the template that displays all pages by default.
 * Please note that this is the WordPress construct of pages
 * and that other 'pages' on your WordPress site will use a
 * different template.
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */

get_header(); ?>
	<?php $options = get_option('minisch_theme_options'); ?>
	<?php if ( $options['colonne1'] ) : ?>
		<?php get_sidebar(); ?>
	<?php endif; ?>

		<section id="flux">

				<?php while ( have_posts() ) : the_post(); ?>

					<?php get_template_part( 'content', 'page' ); ?>

					<?php comments_template( '', true ); ?>

				<?php endwhile; // end of the loop. ?>


		</section><!-- #primary -->

<?php get_footer(); ?>
