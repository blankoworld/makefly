<?php
/**
 * The template for displaying 404 pages (Not Found).
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */

get_header(); ?>

	<section id="flux" style="display: block; margin: 0pt auto; padding: 1px 0pt 30px;">

			<article style="text-align: center;" id="post-0" class="post error404 not-found">
				<header class="entry-header">
					<h1 style="font-size: 30px;" class="entry-title">
					<?php $options = get_option('minisch_theme_options'); ?>
					<?php if ( $options['titre404'] ) : ?>
						<?php
						    $options = get_option('minisch_theme_options');
						    echo $options['titre404'];
						?>
					<?php else : ?>
						<?php _e( 'Oops. Looks like you did something wrong !', 'minisch' ); ?></h1>
					<?php endif; ?>
				</header>

				<div class="entry-content">
					<p>
					<?php $options = get_option('minisch_theme_options'); ?>
					<?php if ( $options['texte404'] ) : ?>
						<?php
						    $options = get_option('minisch_theme_options');
						    echo $options['texte404'];
						?>
					<?php else : ?>
						<strong><?php _e( 'I couldn\'t find what you were looking for ! ', 'minisch' ); ?></strong>.&nbsp;<?php _e( 'Try again with other keywords...', 'minisch' ); ?></p>
					<?php endif; ?>

					<?php get_search_form(); ?>

				</div><!-- .entry-content -->
			</article><!-- #post-0 -->

	</section><!-- #primary -->

<?php get_footer(); ?>
