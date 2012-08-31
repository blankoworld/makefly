<?php
/**
 * The template for displaying image attachments.
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */

get_header(); ?>

		<section id="flux" class="image-attachment">
			<?php while ( have_posts() ) : the_post(); ?>

				<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
					<header class="entry-header">
						<h1 class="entry-title"><?php the_title(); ?></h1>

						<header class="entry-meta">
			                                <time class="entry-date"><a href="<?php the_permalink(); ?>"><?php the_time(get_option('date_format')); ?></a></time>

							<?php
								$metadata = wp_get_attachment_metadata();
								printf( __( '<a href="%3$s" title="Link to full-size image">%4$s &times; %5$s</a>. - <strong><a href="%6$s" title="Return to %7$s" rel="gallery">%7$s</a></strong>', 'minisch' ),
									esc_attr( get_the_time() ),
									get_the_date(),
									wp_get_attachment_url(),
									$metadata['width'],
									$metadata['height'],
									get_permalink( $post->post_parent ),
									get_the_title( $post->post_parent )
								);
							?>
							<?php edit_post_link( __( 'Edit', 'minisch' ), '<span class="sep">|</span> <span class="edit-link">', '</span>' ); ?>
						</header><!-- .entry-meta -->
					</header><!-- .entry-header -->

					<div class="entry-content">

						<div class="entry-attachment">
							<div class="attachment">
								<?php
									/**
									 * Grab the IDs of all the image attachments in a gallery so we can get the URL of the next adjacent image in a gallery,
									 * or the first image (if we're looking at the last image in a gallery), or, in a gallery of one, just the link to that image file
									 */
									$attachments = array_values( get_children( array( 'post_parent' => $post->post_parent, 'post_status' => 'inherit', 'post_type' => 'attachment', 'post_mime_type' => 'image', 'order' => 'ASC', 'orderby' => 'menu_order ID' ) ) );
									foreach ( $attachments as $k => $attachment ) {
										if ( $attachment->ID == $post->ID )
											break;
									}
									$k++;
									// If there is more than 1 attachment in a gallery
									if ( count( $attachments ) > 1 ) {
										if ( isset( $attachments[ $k ] ) )
											// get the URL of the next image attachment
											$next_attachment_url = get_attachment_link( $attachments[ $k ]->ID );
										else
											// or get the URL of the first image attachment
											$next_attachment_url = get_attachment_link( $attachments[ 0 ]->ID );
									} else {
										// or, if there's only 1 image, get the URL of the image
										$next_attachment_url = wp_get_attachment_url();
									}
								?>

								<a href="<?php echo $next_attachment_url; ?>" title="<?php echo esc_attr( get_the_title() ); ?>" rel="attachment"><?php
								$attachment_size = apply_filters( 'minisch_attachment_size', 1200 );
								echo wp_get_attachment_image( $post->ID, array( $attachment_size, $attachment_size ) ); // filterable image width with, essentially, no limit for image height.
								?></a>
							</div><!-- .attachment -->

							<?php if ( ! empty( $post->post_excerpt ) ) : ?>
							<div class="entry-caption">
								<?php the_excerpt(); ?>
							</div>
							<?php endif; ?>
						</div><!-- .entry-attachment -->

						<?php the_content(); ?>
						<?php wp_link_pages( array( 'before' => '<div class="page-link">' . __( 'Pages:', 'minisch' ), 'after' => '</div>' ) ); ?>

					</div><!-- .entry-content -->

					<footer class="entry-meta">
						<?php if ( comments_open() && pings_open() ) : // Comments and trackbacks open ?>
							<?php printf( __( '<a class="comment-link" href="#respond" title="Post a comment">Laisser un commentaire</a> ou partager: <a class="trackback-link" href="%s" title="Trackback URL for your post" rel="trackback">Lien de Partage (Trackback)</a>.', 'minisch' ), get_trackback_url() ); ?>
						<?php elseif ( ! comments_open() && pings_open() ) : // Only trackbacks open ?>
							<?php printf( __( 'Les commentaires sont fermés, mais vous pouvez partager: <a class="trackback-link" href="%s" title="Trackback URL for your post" rel="trackback">lien de partage (trackback)</a>.', 'minisch' ), get_trackback_url() ); ?>
						<?php elseif ( comments_open() && ! pings_open() ) : // Only comments open ?>
							<?php _e( 'Les Trackback sont fermés, mais vous pouvez laissez un <a class="comment-link" href="#respond" title="Post a comment">commentaire.</a>.', 'minisch' ); ?>
						<?php elseif ( ! comments_open() && ! pings_open() ) : // Comments and trackbacks closed ?>
							<?php _e( 'Les commentaires et trackbacks sont fermés.', 'minisch' ); ?>
						<?php endif; ?>
						<?php edit_post_link( __( 'Edit', 'minisch' ), ' <span class="edit-link">', '</span>' ); ?>
					</footer><!-- .entry-meta -->
				</article><!-- #post-<?php the_ID(); ?> -->

				<?php comments_template(); ?>

			<?php endwhile; // end of the loop. ?>
		</section><!-- #primary -->

<?php get_footer(); ?>
