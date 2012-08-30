<?php
/**
 * The main template file.
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */

get_header(); ?>
<?php get_sidebar(); ?>

		<section id="flux">
			
			<?php if ( have_posts() ) : ?>

		<?php if ( get_previous_posts_link() ) : ?>
		<nav class="pagination nav-next"><?php previous_posts_link( __( 'Newer Posts', 'minisch' ) ); ?></nav>
		<?php endif; ?>

				<?php /* Start the Loop */ ?>
				<?php while ( have_posts() ) : the_post(); ?>

					<?php
						/* Include the Post-Format-specific template for the content.
						 * If you want to overload this in a child theme then include a file
						 * called content-___.php (where ___ is the Post Format name) and that will be used instead.
						 */
						get_template_part( 'content', get_post_format() );
					?>

				<?php endwhile; ?>

 		<?php if ( get_next_posts_link() ) : ?>
		<nav class="pagination nav-previous"><?php next_posts_link( __( 'Older Posts', 'minisch' ) ); ?></nav>
		<?php endif; ?>

			<?php else : ?>

				<article id="post-0" class="post no-results not-found">
					<header class="entry-header">
						<h1 class="entry-title"><?php _e( 'Nothing Found', 'minisch' ); ?></h1>
					</header><!-- .entry-header -->

					<div class="entry-content">
						<p><?php _e( 'It seems we can&rsquo;t find what you&rsquo;re looking for. Perhaps searching can help.', 'minisch' ); ?></p>
						<?php get_search_form(); ?>
					</div><!-- .entry-content -->
				</article><!-- #post-0 -->

			<?php endif; ?>

		</section><!-- #primary -->

<?php get_footer(); ?>
