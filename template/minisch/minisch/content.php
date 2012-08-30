<?php
/**
 * @package WordPress
 * @subpackage minisch
 */
?>

<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>

	<?php $options = get_option('minisch_theme_options'); ?>
	<?php if ( $options['firstp'] ) : ?>
		<?php $firstp = $options['firstp']; ?>
	<?php else : ?>
		<?php $firstp = 2; ?>
	<?php endif; ?>
	<?php if ( ! $options['alaune1'] ) : ?>
		<?php if ( $options['alaune2'] == "0" ) : ?>
			<?php if ($wp_query->current_post < $firstp) : ?>
				<?php if ( has_post_thumbnail() ) : ?>
					<figure class="featuredimage">
						<a href="<?php the_permalink(); ?>" rel="bookmark"><?php the_post_thumbnail(); ?></a>
					</figure>
				<?php endif; // thumbnail ?>
			<?php elseif ( is_sticky() ) : ?>
				<?php if ( has_post_thumbnail() ) : ?>
					<figure class="featuredimage">
						<a href="<?php the_permalink(); ?>" rel="bookmark"><?php the_post_thumbnail(); ?></a>
					</figure>
				<?php endif; // thumbnail ?>
			<?php endif; ?>
		<?php elseif ( $options['alaune2'] == "1" ) : ?>
			<?php if ( has_post_thumbnail() ) : ?>
				<figure class="featuredimage">
					<a href="<?php the_permalink(); ?>" rel="bookmark"><?php the_post_thumbnail(); ?></a>
				</figure>
			<?php endif; // thumbnail ?>
		<?php elseif ( $options['alaune2'] == "2" ) : ?>
		<?php elseif ( ! has_post_format( 'aside' )) : ?>
		<?php else : ?>
			<?php if ($wp_query->current_post < $firstp) : ?>
				<?php if ( has_post_thumbnail() ) : ?>
					<figure class="featuredimage">
						<a href="<?php the_permalink(); ?>" rel="bookmark"><?php the_post_thumbnail(); ?></a>
					</figure>
				<?php endif; // thumbnail ?>
			<?php elseif ( is_sticky() ) : ?>
				<?php if ( has_post_thumbnail() ) : ?>
					<figure class="featuredimage">
						<a href="<?php the_permalink(); ?>" rel="bookmark"><?php the_post_thumbnail(); ?></a>
					</figure>
				<?php endif; // thumbnail ?>
			<?php endif; ?>
		<?php endif; ?>
	<?php endif; ?>

	<header class="entry-header">
		<?php if ( comments_open() || ( '0' != get_comments_number() && ! comments_open() ) ) : ?>
			<span class="comments-link"><?php comments_popup_link( __( '…' ), __( '1', 'minisch' ), __( '%', 'minisch' ) ); ?></span>
		<?php endif; ?>
		<?php if ( has_post_format( 'aside' )) : ?>
			<section class="extrait"><?php the_content(); ?></section>
		<?php else : ?>
			<h1 class="entry-title"><a href="<?php the_permalink(); ?>" title="<?php _e('Permalink: ', 'minisch'); ?><?php printf( esc_attr__( '%s', 'minisch' ), the_title_attribute( 'echo=0' ) ); ?>" rel="bookmark"><?php the_title(); ?></a></h1>
		<?php endif; ?>

		<?php if ( 'post' == get_post_type() ) : ?>
		<div class="entry-meta">
			<?php if ( is_sticky() ) : ?>
				<span class="label alaune"><?php _e('Featured', 'minisch'); ?></span>
			<?php endif; // sticky ?>
			<?php if ( has_post_format( 'aside' )) : ?>
				<span class="label aside"><?php _e('Aside', 'minisch'); ?></span>
			<?php endif; ?>
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

			<?php
				/* translators: used between list items, there is a space after the comma */
				$tags_list = get_the_tag_list( '', __( ', ', 'minisch' ) );
				if ( $tags_list ) :
			?>
			<?php endif; // End if $tags_list ?>
			<span class="tag-links">
				<?php printf( __( '%1$s', 'minisch' ), $tags_list ); ?>
			</span>
		</div><!-- .entry-meta -->
		<?php endif; ?>

<?php if ( ! has_post_format( 'aside' )) : ?>
	<?php if ( $options['extrait'] == "0" ) : ?>
		<?php if ($wp_query->current_post < $firstp) : ?>
			<?php if ( ! has_post_thumbnail() ) : ?>
				<section class="extrait"><?php the_excerpt(); ?></section>
			<?php endif; ?>
		<?php elseif ( is_sticky() ) : ?>
			<?php if ( ! has_post_thumbnail() ) : ?>
				<section class="extrait"><?php the_excerpt(); ?></section>
			<?php endif; ?>
		<?php endif; ?>
	<?php elseif ( $options['extrait'] == "1" ) : ?>
			<section class="extrait"><?php the_excerpt(); ?></section>
	<?php elseif ( $options['extrait'] == "2" ) : ?>
	<?php elseif ( $options['extrait'] == "3" ) : ?>
		<?php if ( ! has_post_thumbnail() ) : ?>
			<section class="extrait"><?php the_excerpt(); ?></section>
		<?php endif; ?>
	<?php else : ?>
		<?php if ($wp_query->current_post < $firstp) : ?>
			<?php if ( ! has_post_thumbnail() ) : ?>
				<section class="extrait"><?php the_excerpt(); ?></section>
			<?php endif; ?>
		<?php elseif ( is_sticky() ) : ?>
			<?php if ( ! has_post_thumbnail() ) : ?>
				<section class="extrait"><?php the_excerpt(); ?></section>
			<?php endif; ?>
		<?php endif; ?>
	<?php endif; ?>
<?php endif; ?>
	</header><!-- .entry-header -->

	</footer><!-- #entry-meta -->
</article><!-- #post-<?php the_ID(); ?> -->
