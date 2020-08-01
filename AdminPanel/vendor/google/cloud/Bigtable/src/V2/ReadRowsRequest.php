<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/bigtable/v2/bigtable.proto

namespace Google\Cloud\Bigtable\V2;

use Google\Protobuf\Internal\GPBType;
use Google\Protobuf\Internal\RepeatedField;
use Google\Protobuf\Internal\GPBUtil;

/**
 * Request message for Bigtable.ReadRows.
 *
 * Generated from protobuf message <code>google.bigtable.v2.ReadRowsRequest</code>
 */
class ReadRowsRequest extends \Google\Protobuf\Internal\Message
{
    /**
     * Required. The unique name of the table from which to read.
     * Values are of the form
     * `projects/<project>/instances/<instance>/tables/<table>`.
     *
     * Generated from protobuf field <code>string table_name = 1 [(.google.api.field_behavior) = REQUIRED, (.google.api.resource_reference) = {</code>
     */
    private $table_name = '';
    /**
     * This value specifies routing for replication. If not specified, the
     * "default" application profile will be used.
     *
     * Generated from protobuf field <code>string app_profile_id = 5;</code>
     */
    private $app_profile_id = '';
    /**
     * The row keys and/or ranges to read. If not specified, reads from all rows.
     *
     * Generated from protobuf field <code>.google.bigtable.v2.RowSet rows = 2;</code>
     */
    private $rows = null;
    /**
     * The filter to apply to the contents of the specified row(s). If unset,
     * reads the entirety of each row.
     *
     * Generated from protobuf field <code>.google.bigtable.v2.RowFilter filter = 3;</code>
     */
    private $filter = null;
    /**
     * The read will terminate after committing to N rows' worth of results. The
     * default (zero) is to return all results.
     *
     * Generated from protobuf field <code>int64 rows_limit = 4;</code>
     */
    private $rows_limit = 0;

    /**
     * Constructor.
     *
     * @param array $data {
     *     Optional. Data for populating the Message object.
     *
     *     @type string $table_name
     *           Required. The unique name of the table from which to read.
     *           Values are of the form
     *           `projects/<project>/instances/<instance>/tables/<table>`.
     *     @type string $app_profile_id
     *           This value specifies routing for replication. If not specified, the
     *           "default" application profile will be used.
     *     @type \Google\Cloud\Bigtable\V2\RowSet $rows
     *           The row keys and/or ranges to read. If not specified, reads from all rows.
     *     @type \Google\Cloud\Bigtable\V2\RowFilter $filter
     *           The filter to apply to the contents of the specified row(s). If unset,
     *           reads the entirety of each row.
     *     @type int|string $rows_limit
     *           The read will terminate after committing to N rows' worth of results. The
     *           default (zero) is to return all results.
     * }
     */
    public function __construct($data = NULL) {
        \GPBMetadata\Google\Bigtable\V2\Bigtable::initOnce();
        parent::__construct($data);
    }

    /**
     * Required. The unique name of the table from which to read.
     * Values are of the form
     * `projects/<project>/instances/<instance>/tables/<table>`.
     *
     * Generated from protobuf field <code>string table_name = 1 [(.google.api.field_behavior) = REQUIRED, (.google.api.resource_reference) = {</code>
     * @return string
     */
    public function getTableName()
    {
        return $this->table_name;
    }

    /**
     * Required. The unique name of the table from which to read.
     * Values are of the form
     * `projects/<project>/instances/<instance>/tables/<table>`.
     *
     * Generated from protobuf field <code>string table_name = 1 [(.google.api.field_behavior) = REQUIRED, (.google.api.resource_reference) = {</code>
     * @param string $var
     * @return $this
     */
    public function setTableName($var)
    {
        GPBUtil::checkString($var, True);
        $this->table_name = $var;

        return $this;
    }

    /**
     * This value specifies routing for replication. If not specified, the
     * "default" application profile will be used.
     *
     * Generated from protobuf field <code>string app_profile_id = 5;</code>
     * @return string
     */
    public function getAppProfileId()
    {
        return $this->app_profile_id;
    }

    /**
     * This value specifies routing for replication. If not specified, the
     * "default" application profile will be used.
     *
     * Generated from protobuf field <code>string app_profile_id = 5;</code>
     * @param string $var
     * @return $this
     */
    public function setAppProfileId($var)
    {
        GPBUtil::checkString($var, True);
        $this->app_profile_id = $var;

        return $this;
    }

    /**
     * The row keys and/or ranges to read. If not specified, reads from all rows.
     *
     * Generated from protobuf field <code>.google.bigtable.v2.RowSet rows = 2;</code>
     * @return \Google\Cloud\Bigtable\V2\RowSet
     */
    public function getRows()
    {
        return $this->rows;
    }

    /**
     * The row keys and/or ranges to read. If not specified, reads from all rows.
     *
     * Generated from protobuf field <code>.google.bigtable.v2.RowSet rows = 2;</code>
     * @param \Google\Cloud\Bigtable\V2\RowSet $var
     * @return $this
     */
    public function setRows($var)
    {
        GPBUtil::checkMessage($var, \Google\Cloud\Bigtable\V2\RowSet::class);
        $this->rows = $var;

        return $this;
    }

    /**
     * The filter to apply to the contents of the specified row(s). If unset,
     * reads the entirety of each row.
     *
     * Generated from protobuf field <code>.google.bigtable.v2.RowFilter filter = 3;</code>
     * @return \Google\Cloud\Bigtable\V2\RowFilter
     */
    public function getFilter()
    {
        return $this->filter;
    }

    /**
     * The filter to apply to the contents of the specified row(s). If unset,
     * reads the entirety of each row.
     *
     * Generated from protobuf field <code>.google.bigtable.v2.RowFilter filter = 3;</code>
     * @param \Google\Cloud\Bigtable\V2\RowFilter $var
     * @return $this
     */
    public function setFilter($var)
    {
        GPBUtil::checkMessage($var, \Google\Cloud\Bigtable\V2\RowFilter::class);
        $this->filter = $var;

        return $this;
    }

    /**
     * The read will terminate after committing to N rows' worth of results. The
     * default (zero) is to return all results.
     *
     * Generated from protobuf field <code>int64 rows_limit = 4;</code>
     * @return int|string
     */
    public function getRowsLimit()
    {
        return $this->rows_limit;
    }

    /**
     * The read will terminate after committing to N rows' worth of results. The
     * default (zero) is to return all results.
     *
     * Generated from protobuf field <code>int64 rows_limit = 4;</code>
     * @param int|string $var
     * @return $this
     */
    public function setRowsLimit($var)
    {
        GPBUtil::checkInt64($var);
        $this->rows_limit = $var;

        return $this;
    }

}

