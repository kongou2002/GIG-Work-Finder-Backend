package com.seal.api.gwf.entity;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "CommentContent")
public class CommentContentEntity {

    @Id
    @Column(name = "ContentID")
    private int contentID;

    @Column(name = "CommentID")
    private int commentID;

    @Column(name = "Content", columnDefinition = "ntext")
    private String content;
}
