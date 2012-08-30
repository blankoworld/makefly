<?php
/**
 * The template for displaying Search Results pages.
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */

get_header(); ?>
<?php get_sidebar(); ?>

		<section id="flux">

			<?php if ( have_posts() ) : ?>

				<header class="page-header">
					<h1 class="page-title"><?php _e('Search : ', 'minisch'); ?><?php printf( __( '<strong>%s</strong>', 'minisch' ), '<span>' . get_search_query() . '</span>' ); ?></h1>
				</header>

		<?php if ( get_previous_posts_link() ) : ?>
		<nav class="pagination nav-next"><?php previous_posts_link( __( 'Newer Posts', 'minisch' ) ); ?></nav>
		<?php endif; ?>

				<?php /* Start the Loop */ ?>
				<?php while ( have_posts() ) : the_post(); ?>

					<?php get_template_part( 'content', 'search' ); ?>

				<?php endwhile; ?>

 		<?php if ( get_next_posts_link() ) : ?>
		<nav class="pagination nav-previous"><?php next_posts_link( __( 'Older Posts', 'minisch' ) ); ?></nav>
		<?php endif; ?>

			<?php else : ?>

				<article id="post-0" class="post no-results not-found">
					<header class="entry-header">
						<h1 class="entry-title"><?php _e( 'Oops, nothing found ...', 'minisch' ); ?></h1>
					
						<p><?php _e('Sorry. I couldn\'t find what you were looking for.<br>Try something else ! Or maybe you should navigate through the blog archives.', 'minisch'); ?></p>
						<?php get_search_form(); ?>
					</header><!-- .entry-header -->
				</article><!-- #post-0 -->

			<?php endif; ?>

		</section><!-- #primary -->

<?php get_footer(); ?>
