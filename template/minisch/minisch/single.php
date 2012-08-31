<?php
/**
 * The Template for displaying all single posts.
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
			<h1 class="entry-title"><?php the_title(); ?></h1>
			<header class="entry-meta">
				<time class="entry-date"><a href="<?php the_permalink(); ?>"><?php the_time(get_option('date_format')); ?></a></time>
				<?php
					/* translators: used between list items, there is a space after the comma */
					$categories_list = get_the_category_list( __( ', ', 'minisch' ) );
					if ( $categories_list ):
				?>
				<span class="cat-links">
					<?php printf( __( '%2$s • ', 'minisch' ), 'entry-utility-prep entry-utility-prep-cat-links', $categories_list );
					$show_sep = true; ?>
				</span>
				<?php endif; // End if categories ?>

				<span class="tag-links">
				<?php
					/* translators: used between list items, there is a space after the comma */
					$tags_list = get_the_tag_list( '', __( ', ', 'minisch' ) );
					if ( $tags_list ) :
				?>
				<?php endif; // End if $tags_list ?>
				<?php printf( __( '%1$s', 'minisch' ), $tags_list ); ?>
				</span>
			</header>

			<?php while ( have_posts() ) : the_post(); ?>

				<?php get_template_part( 'content', 'single' ); ?>

				<?php comments_template( '', true ); ?>

			<?php endwhile; // end of the loop. ?>

		</section><!-- #primary -->

<?php get_footer(); ?>
