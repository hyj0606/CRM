package com.pojo;

public class Role {

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_role.id
     *
     * @mbggenerated Tue Nov 29 16:03:52 CST 2022
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tb_role.role_name
     *
     * @mbggenerated Tue Nov 29 16:03:52 CST 2022
     */
    private String roleName;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_role.id
     *
     * @return the value of tb_role.id
     *
     * @mbggenerated Tue Nov 29 16:03:52 CST 2022
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_role.id
     *
     * @param id the value for tb_role.id
     *
     * @mbggenerated Tue Nov 29 16:03:52 CST 2022
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tb_role.role_name
     *
     * @return the value of tb_role.role_name
     *
     * @mbggenerated Tue Nov 29 16:03:52 CST 2022
     */
    public String getRoleName() {
        return roleName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tb_role.role_name
     *
     * @param roleName the value for tb_role.role_name
     *
     * @mbggenerated Tue Nov 29 16:03:52 CST 2022
     */
    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }
}